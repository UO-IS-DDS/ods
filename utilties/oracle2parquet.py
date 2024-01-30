import pandas as pd
import pyarrow as pa
import os
import sqlalchemy as sa
from concurrent.futures import ProcessPoolExecutor
import threading
import datetime

# Oracle Database Connection Configuration
oracle_username = 'lampman'
oracle_password = '***'
oracle_host = 'daisy-cl.uoregon.edu'
oracle_port = '1560'
oracle_service_name = 'ban_adh_prod'
oracle_connection_string = f'oracle+oracledb://{oracle_username}:{oracle_password}@{oracle_host}:{oracle_port}/?service_name={oracle_service_name}'

 # Create an SQLAlchemy engine
engine = sa.create_engine(oracle_connection_string)
    
# Get column names and data types from all_tab_cols with schema qualification
connection = engine.connect()

# Define the Parquet root directory
parquet_root_directory = '../../ods_parquet'

# Create the root directory if it doesn't exist
os.makedirs(parquet_root_directory, exist_ok=True)

# List to store SQL queries for tables with Date/Encoding issues
sql_list = []

# Oracle tables to write to parquet
for schema, table_name in [
                           # General Domain
                           ('general','goremal',),
                           ('general','gtvemal',),
                           ('saturn', 'spbpers',),
                           ('saturn', 'spraddr',),
                           ('saturn', 'spriden',),
                           ('saturn', 'sprtele',),
                           ('saturn', 'stvatyp',),
                           ('saturn', 'stvnatn',),
                           ('saturn', 'stvstat',),
                           ('saturn', 'stvtele',),
                           
                           # Registrar Domain
                           ('saturn','sfrstcr'),
                           ('saturn','sgbstdn'),
                           ('saturn','sgradvr'),
                           ('saturn','sgrchrt'),
                           ('saturn','sgrclsr'),
                           ('saturn','sgrsatt'),
                           ('saturn','shrlgpa'),
                           ('saturn','shrtgpa'),
                           ('saturn','shrtrce'),
                           ('saturn','shrttrm'),
                           ('saturn','sorlcur'),
                           ('saturn','sorlfos'),
                           ('saturn','stvastd'),
                           ('saturn','stvatts'),
                           ('saturn','stvchrt'),
                           ('saturn','stvclas'),
                           ('saturn','stvcoll'),
                           ('saturn','stvdept'),
                           ('saturn','stvests'),
                           ('saturn','stvlevl'),
                           ('saturn','stvmajr'),
                           ('saturn','stvrsts'),
                           ('saturn','stvstyp'),
                           ('saturn','stvterm'),
                           ('saturn','sfbetrm'),
                           ('saturn','swbtded')
						  ]:
    

    query = sa.text(f" SELECT t.column_name, t.data_type "
                    f" FROM all_tab_cols t"
                    f" WHERE owner = UPPER('{schema}') "
                    f"   AND table_name = UPPER('{table_name}') "
                    f"   AND t.NUM_DISTINCT > 0 "
                    f"   AND t.COLUMN_NAME NOT LIKE '%_SURROGATE_ID' "
                    f"   AND t.COLUMN_NAME NOT LIKE '%_VERSION' "
                    f" ORDER BY column_id")
    result = connection.execute(query)
    
    select_columns = ""
    
    # Define a dictionary of data types to their corresponding encodings
    string_datatypes = ['CHAR',
                        'CLOB',
                        'VARCHAR2',
                        'RAW']
    date_datatypes = ['DATE',
                       'TIMESTAMP(6)',
                       'TIMESTAMP(9)']
    
    for row in result:
        column_name, data_type = row
        # Handle data types in encoding_mapping by casting to the specified encoding
        if data_type in string_datatypes:
            select_columns += f" convert({column_name}, 'UTF8', 'AL32UTF8') as {column_name},"
        elif data_type in date_datatypes:
            # Handle date transformation - floor non-null dates to 1/1/1000
            select_columns += f" case when {column_name} is not null and {column_name} < to_date('01-JAN-1000','DD-MON-YYYY') then to_date('01-JAN-1000','DD-MON-YYYY') end as {column_name},"
        else:
            select_columns += f" {column_name}, "
    if select_columns.endswith(","):
      select_columns = select_columns[:-1]
    select_query = f"SELECT {select_columns} from {schema}.{table_name}"
    sql_list.append(select_query)


# Chunk Size for Reading Data
chunk_size = 500000

def process_query(sql):
    from_position = sql.find("from")
    if from_position != -1:
      table_name = sql[from_position + len("FROM"):].strip()
    # Extract table name from SQL
    
    print (f"Starting to process {table_name}")
    
    chunk_number = 0
    table_directory = os.path.join(parquet_root_directory, table_name)
    os.makedirs(table_directory, exist_ok=True)
    
    for chunk in pd.read_sql(sql, engine, chunksize=chunk_size):
        chunk_file_name = f"{table_name}_{chunk_number}.parquet"
        chunk_file_path = os.path.join(table_directory, chunk_file_name)
        print(f"Saving chunk {chunk_number} in directory {table_name}")
        
        chunk.to_parquet(chunk_file_path, index=False)
        chunk_number += 1
    print (f"Done processing {table_name}")

if __name__ == '__main__':

    max_processes = 6
    with ProcessPoolExecutor(max_processes) as executor:
        futures = [executor.submit(process_query, sql) for i, sql in enumerate(sql_list)]
    for future in futures:
        future.result()
    print("Data processing complete.")
    connection.close()
