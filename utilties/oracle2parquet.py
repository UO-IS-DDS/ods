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

# Create the root directory if it doesn't exist
os.makedirs(parquet_root_directory, exist_ok=True)

sql_list = [    
    # General Domain
    #'select * from general.goremal',
    #'select * from general.gtvemal',
    #'select * from saturn.spbpers',
    #'select * from saturn.spraddr'
    #'select * from saturn.spriden',
    #'select * from saturn.sprtele',
    #'select * from saturn.stvatyp',
    #'select * from saturn.stvnatn',
    #'select * from saturn.stvstat',
    #'select * from saturn.stvtele',
    
    # Registrar Domain
    #'select * from saturn.sfrstcr',
    #'select * from saturn.sgbstdn',
    #'select * from saturn.sgradvr',
    #'select * from saturn.sgrchrt',
    #'select * from saturn.sgrclsr',
    #'select * from saturn.sgrsatt',
    #'select * from saturn.shrlgpa',
    #'select * from saturn.shrtgpa',
    #'select * from saturn.shrtrce',
    #'select * from saturn.shrttrm',
    #'select * from saturn.sorlcur',
    #'select * from saturn.sorlfos',
    #'select * from saturn.stvastd',
    #'select * from saturn.stvatts',
    #'select * from saturn.stvchrt',
    #'select * from saturn.stvclas',
    #'select * from saturn.stvcoll',
    #'select * from saturn.stvdept',
    #'select * from saturn.stvests',
    #'select * from saturn.stvlevl',
    #'select * from saturn.stvmajr',
    #'select * from saturn.stvrsts',
    #'select * from saturn.stvstyp',
    #'select * from saturn.stvterm',
    #'select * from saturn.sfbetrm',
    #'select * from saturn.swbtded'
    ]

# Tables with Date/Encoding issues
for schema, table_name in [('saturn', 'spraddr')]:
    

    query = sa.text(f"SELECT column_name, data_type FROM all_tab_cols WHERE owner = UPPER('{schema}') AND table_name = UPPER('{table_name}') order by column_id")
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
    select_query = ""
    if select_columns.endswith(","):
      select_columns = select_columns[:-1]
    sql_list.append(f"select {select_columns} from {schema}.{table_name} where mod(spraddr_surrogate_id, 8) = 0")
    sql_list.append(f"select {select_columns} from {schema}.{table_name} where mod(spraddr_surrogate_id, 8) = 1")
    sql_list.append(f"select {select_columns} from {schema}.{table_name} where mod(spraddr_surrogate_id, 8) = 2")
    sql_list.append(f"select {select_columns} from {schema}.{table_name} where mod(spraddr_surrogate_id, 8) = 3")
    sql_list.append(f"select {select_columns} from {schema}.{table_name} where mod(spraddr_surrogate_id, 8) = 4")
    sql_list.append(f"select {select_columns} from {schema}.{table_name} where mod(spraddr_surrogate_id, 8) = 5")
    sql_list.append(f"select {select_columns} from {schema}.{table_name} where mod(spraddr_surrogate_id, 8) = 6")
    sql_list.append(f"select {select_columns} from {schema}.{table_name} where mod(spraddr_surrogate_id, 8) = 7")


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
