import pandas as pd
import pyarrow as pa
import os
import sqlalchemy as sa
from concurrent.futures import ProcessPoolExecutor
import datetime
import json
import sys

def load_config(config_name):
    with open('../config.json') as f:
        config = json.load(f)
    return config.get(config_name)

if len(sys.argv) != 2:
    print("Usage: python oracle2parquet.py <config_name>")
config_name = sys.argv[1]
config = load_config(config_name)
if not config:
    print(f"Config '{config_name}' not found outside repo in config.json in ../")
    sys.exit(1)
    
# Oracle Database Connection Configuration
oracle_username = config['oracle_username']
oracle_password = config['oracle_password']
oracle_host = config['oracle_host']
oracle_port = config['oracle_port']
oracle_service_name = config['oracle_service_name']
oracle_connection_string = f'oracle+oracledb://{oracle_username}:{oracle_password}@{oracle_host}:{oracle_port}/?service_name={oracle_service_name}'

 # Create an SQLAlchemy engine
engine = sa.create_engine(oracle_connection_string)
    
# Get column names and data types from all_tab_cols with schema qualification
connection = engine.connect()
# Define the Parquet root directory
parquet_root_directory = config['parquet_root_directory']#'../../ods_parquet'

# Define the Banner Tables manifest directory
tables_manifest_path = config['tables_manifest_path']#'utilties/banner_tables.csv'
banner_df = pd.read_csv(tables_manifest_path)

# Create the root directory if it doesn't exist
os.makedirs(parquet_root_directory, exist_ok=True)

sql_list = []

# Loop through Banner tables in manifest
for index, row in banner_df.iterrows():

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
            select_columns += (f" case when {column_name} is not null and {column_name} < to_date('01-JAN-1000','DD-MON-YYYY')"
                               f"   then to_date('01-JAN-1000','DD-MON-YYYY')"
                               f"   else {column_name}"
                               f" end as {column_name},")
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

connection.close()
# Chunk Size for Reading Data
chunk_size = 500000

def process_query(sql):

    # Find the position of 'from' and 'where'
    from_position = sql.find(" from ")
    where_position = sql.find(" where ")

    if from_position != -1 and where_position != -1:
        # Extract the table name between 'from' and 'where'
        table_name = sql[from_position + len(" from "):where_position].strip()
    
    csv_row = banner_df['table_name'] == table_name.split('.')[1]
    domain     = banner_df.loc[csv_row, 'domain'].iloc[0]
    total_rows = banner_df.loc[csv_row, 'count'].iloc[0]
    
    chunk_number = 0
    table_directory = os.path.join(parquet_root_directory, domain + '/' + table_name)
    os.makedirs(table_directory, exist_ok=True)
    
    files = os.listdir(table_directory)
        
    for file in files:
        file_path = os.path.join(table_directory, file)
        os.remove(file_path)
    
    for chunk in pd.read_sql(sql, engine, chunksize=chunk_size):
        timestamp = datetime.datetime.now().strftime("%H%M%S_%f")
        chunk_file_name = f"{table_name}_{chunk_number}_{timestamp}.parquet"
        chunk_file_path = os.path.join(table_directory, chunk_file_name)
        
        num_files = sum(1 for file in os.listdir(table_directory))
        
        if total_rows > 500000:
            percent = round(((num_files * 500000)/total_rows) * 100)
            percent = min(percent, 100)
            print(f"{table_name} at {percent} %")
        
        chunk.to_parquet(chunk_file_path, index=False)
        chunk_number += 1
    print (f"Done processing {table_name}")

if __name__ == '__main__':
    print (f"Generating SQL to run...")
    max_processes = 8
    with ProcessPoolExecutor(max_processes) as executor:
        futures = [executor.submit(process_query, sql) for i, sql in enumerate(sql_list)]
    for future in futures:
        future.result()
    print("Data processing complete.")

