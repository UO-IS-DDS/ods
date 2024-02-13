#!/bin/bash
# Loads parquet files to DuckDB tables based on parquet parent directory name

# Expected samepl directory structure
#     ods
#     |- utilities
#        |- parquet2duckdb.sh
#     ods.duckdb
#     ods_parquet
#     |- GOREMAL
#        |- combined.parquet

# Set DuckDB database name
db_name="../../ods.duckdb"

# Set the path to the parent parquet directory containing subdirectories
parent_directory="../../ods_parquet"

# Function to load "combined.parquet" into DuckDB table
load_combined_parquet_into_duckdb() {
    local directory="$1"

    # Extract the table name from the parent directory name and convert to lowercase
    table_name=$(basename "$directory" | tr '[:upper:]' '[:lower:]')

    # Construct the full path to the "combined.parquet" file
    parquet_file="$directory/combined.parquet"

    # Check if the table already exists and drop it if it does
    duckdb "$db_name" "DROP TABLE IF EXISTS banner.$table_name"

    # Load Parquet data into DuckDB using COPY statement
    duckdb "$db_name" "CREATE TABLE banner.$table_name AS SELECT * FROM read_parquet('$parquet_file')"
}

# Loop through subdirectories and load "combined.parquet" into DuckDB tables
for directory in "$parent_directory"/*; do
    echo $directory
    load_combined_parquet_into_duckdb "$directory"
done
