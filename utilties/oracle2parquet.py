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
oracle_host = 'ioepcl.uoregon.edu'
oracle_port = '1560'
oracle_service_name = 'ioe_prod.uoregon.edu'
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
for index, row in banner_df.iterrows():
    stat_count = row['count']
    domain     = row['domain']
    schema     = row['schema']
    table_name = row['table_name']
    table_key  = row['table_key']
    
    query = sa.text(f"SELECT column_name, data_type FROM dba_tab_columns WHERE owner = UPPER('{schema}') AND table_name = UPPER('{table_name}') order by column_id")
    result = connection.execute(query)
    
    
    columns = []
    select_columns = ""
    
    # Define a dictionary of data types to their corresponding encodings
    string_datatypes = ['CHAR',
                        'CLOB',
                        'VARCHAR2',
                        'RAW']
    date_datatypes = ['DATE',
                       'TIMESTAMP(6)',
                       'TIMESTAMP(9)']
    
    for rec in result:
        column_name, data_type = rec
        # Handle data types in encoding_mapping by casting to the specified encoding
        if data_type in string_datatypes:
            select_columns += f" convert({column_name}, 'UTF8', 'AL32UTF8') as {column_name},"
        elif data_type in date_datatypes:
            # Handle date transformation - floor non-null dates to 1/1/1000
            select_columns += f" case when {column_name} is not null and {column_name} < to_date('01-JAN-1000','DD-MON-YYYY') then to_date('01-JAN-1000','DD-MON-YYYY') end as {column_name},"
        else:
            select_columns += f" {column_name}, "
    select_query = ""
    if select_columns.endswith(","):
      select_columns = select_columns[:-1]
    if table_key == 'none':
        sql_list.append(f"select {select_columns} from {schema}.{table_name} where 1=1")
    else:
        for i in range(8):
            sql_list.append(f"select {select_columns} from {schema}.{table_name} where mod({table_key}, 8) = {i}")
    
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
