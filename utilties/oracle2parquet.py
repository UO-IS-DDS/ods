import os
import pandas as pd
import duckdb
from sqlalchemy import create_engine

# Oracle Database Connection Configuration
oracle_username = 'lampman'
oracle_password = 'pw'
oracle_host = 'eaatcl.uoregon.edu'
oracle_port = '1560'
oracle_service_name = 'EAA_TEST'
oracle_connection_string = f'oracle+oracledb://{oracle_username}:{oracle_password}@{oracle_host}:{oracle_port}/?service_name={oracle_service_name}'

# DuckDB Database File Path
duckdb_file_path = '/Users/brocklampman/DDS/duckdb/ods.duckdb'

# Parquet Files Root Directory
parquet_root_directory = '/Users/brocklampman/Desktop/dump/new'

# List of Source Tables to Process
source_list = [ 
#                'SPRIDEN',
#                'SPBPERS',
#                'GOREMAL',
#                'SPRADDR',
#                'SPRTELE',
#                'SORLCUR',
#                'SORLFOS',
#                'SGBSTDN',
#                'STVMAJR',
#                'STVTERM',
#                'SGRADVR',
#                'STVATTS',
#                'STVLEVL',
#                'STVCHRT',
#                'STVCLAS',
#                'STVCOLL',
#                'STVDEPT',
#                'SHRLGPA',
#                'SHRTGPA',
#                'STVESTS',
#                'SFBETRM',
#                'SGRCHRT',
#                'SGRSATT',
#                'SHRTTRM',
#                'SFRSTCR',
#                'STVRSTS',
#                'STVSTYP',
#                'STVASTD',
#                'SWBTDED',
#                'SHRTRCE',
#                'SGRCLSR',
#                'STVSTAT',
#                'GTVEMAL',
#                'STVATYP',
#                'STVCNTY',
#                'STVNATN',
#                'STUDENT',
#                'PERSON_DETAIL,'
#                'PERSON_ADDRESS_UO'
                 'STVTELE'
]

# SQL Alchemy Engine for Oracle Database
engine = create_engine(oracle_connection_string, thick_mode=None)

# Chunk Size for Reading Data
chunk_size = 500000

def fix_invalid_dates(col):
    """Fixes invalid dates in a DataFrame column."""
    if pd.api.types.is_datetime64_any_dtype(col):
        return pd.to_datetime(col, errors='coerce')  
    return col

def load_parquet_to_duckdb(parquet_file, table_name, conn):
    """Loads a Parquet file into a DuckDB database."""
    df = pd.read_parquet(parquet_file)
    conn.execute(f"DROP TABLE IF EXISTS {table_name}")
    conn.register('temp_df', df)
    conn.execute(f"CREATE TABLE {table_name} AS SELECT * FROM temp_df")
    # Get the row count of the inserted data
    row_count = conn.execute(f"SELECT COUNT(*) FROM {table_name}").fetchone()[0]
    return row_count

# Process Each Source Table
for source in source_list:
    source_directory = os.path.join(parquet_root_directory, source)
    os.makedirs(source_directory, exist_ok=True)

    print(f"Processing {source}")
    query = f"SELECT * FROM {oracle_username}.{source}"
    
    # SPRADDR has bad dates =(
    if source == 'SPRADDR':
        query += (" WHERE (spraddr_activity_date IS NULL OR spraddr_activity_date   > to_date('1000-01-01','YYYY-MM-DD')) AND "
                  "       (spraddr_from_date     IS NULL OR spraddr_from_date       > to_date('1000-01-01','YYYY-MM-DD')) AND "
                  "       (spraddr_to_date       IS NULL OR spraddr_to_date         > to_date('1000-01-01','YYYY-MM-DD')) AND "
                  "       (spraddr_validated_date IS NULL OR spraddr_validated_date > to_date('1000-01-01','YYYY-MM-DD'))"    
        )
    

    # Read and Save Data in Chunks as Parquet Files
    chunk_number = 0
    for chunk in pd.read_sql(query, engine, chunksize=chunk_size):
        chunk_file_name = f"{source_directory}/{source}_{chunk_number}.parquet"
        print(f"Saving chunk {source}_{chunk_number}")
        chunk.to_parquet(chunk_file_name, index=False)
        chunk_number += 1

    # Combine and Save All Chunks as a Single Parquet File
    combined_parquet_path = os.path.join(source_directory, 'combined.parquet')
    dfs = [pd.read_parquet(os.path.join(source_directory, f)) for f in os.listdir(source_directory) if f.endswith('.parquet')]
    combined_df = pd.concat(dfs, ignore_index=True)
    combined_df.to_parquet(combined_parquet_path)

print("Data processing complete.")