import pandas as pd
import pyarrow as pa
import os
import sqlalchemy as sa
from concurrent.futures import ProcessPoolExecutor
import threading
import datetime

# Oracle Database Connection Configuration
oracle_username = 'lampman'
oracle_password = ''
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

# Define the Banner Tables manifest directory
banner_manifest_path = 'utilties/banner_tables.csv'
banner_df = pd.read_csv(banner_manifest_path)

# Create the root directory if it doesn't exist
os.makedirs(parquet_root_directory, exist_ok=True)

sql_list = []

# Loop through Banner tables in manifest
for i in range(8):
  sql_list.append(f"select * from general.GWRDLOG where mod(GWRDLOG_pidm, 8) = {i}")
    
# Chunk Size for Reading Data
chunk_size = 500000

def process_query(sql):
    # Convert the SQL string to lowercase for case-insensitive search
    sql_lower = sql.lower()

    # Find the position of 'from' and 'where'
    from_position = sql_lower.find(" from ")
    where_position = sql_lower.find(" where ")

    if from_position != -1 and where_position != -1:
        # Extract the table name between 'from' and 'where'
        table_name = sql[from_position + len(" from "):where_position].strip()
    
    print (f"Starting to process {table_name}")
    
    chunk_number = 0
    table_directory = os.path.join(parquet_root_directory, table_name)
    os.makedirs(table_directory, exist_ok=True)
    
    for chunk in pd.read_sql(sql, engine, chunksize=chunk_size):
        timestamp = datetime.datetime.now().strftime("%H%M%S_%f")
        chunk_file_name = f"{table_name}_{chunk_number}_{timestamp}.parquet"
        chunk_file_path = os.path.join(table_directory, chunk_file_name)
        print(f"Saving chunk {chunk_number} in directory {table_name}")
        
        chunk.to_parquet(chunk_file_path, index=False)
        chunk_number += 1
    print (f"Done processing {table_name}")

if __name__ == '__main__':

    max_processes = 8
    with ProcessPoolExecutor(max_processes) as executor:
        futures = [executor.submit(process_query, sql) for i, sql in enumerate(sql_list)]
    for future in futures:
        future.result()
    print("Data processing complete.")
    connection.close()
