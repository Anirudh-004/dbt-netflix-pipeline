import os
import pandas as pd
import psycopg2
from airflow.hooks.base import BaseHook
import psycopg2
from io import StringIO
CSV_DIR = '/opt/airflow/data'  # container path

# def get_postgres_conn():
#     return psycopg2.connect(
#         host=os.getenv('DB_HOST'),
#         database=os.getenv('DB_NAME'),
#         user=os.getenv('DB_USER'),
#         password=os.getenv('DB_PASSWORD'),
#         port=os.getenv('DB_PORT')
#     )
def get_postgres_conn():
    conn = BaseHook.get_connection('my_postgres')  # Use your Conn Id here
    psycopg_conn = psycopg2.connect(
        host=conn.host,
        dbname=conn.schema,
        user=conn.login,
        password=conn.password,
        port=conn.port
    )
    return psycopg_conn
def create_table_if_not_exists(table_name, df, cursor):
    dtype_mapping = {
        'int64': 'INTEGER',
        'float64': 'FLOAT',
        'object': 'TEXT',
        'bool': 'BOOLEAN',
        'datetime64[ns]': 'TIMESTAMP'
    }

    columns = []
    for col in df.columns:
        col_type = dtype_mapping.get(str(df[col].dtype), 'TEXT')
        columns.append(f'"{col}" {col_type}')

    create_sql = f"""
    CREATE TABLE IF NOT EXISTS {table_name} (
        {', '.join(columns)}
    );
    """
    cursor.execute(create_sql)



def load_csv_to_postgres(table_name, filename):
    path = os.path.join(CSV_DIR, filename)

    # Load just enough to infer schema & create table
    sample_df = pd.read_csv(path, nrows=100)
    conn = get_postgres_conn()
    cursor = conn.cursor()
    create_table_if_not_exists(table_name, sample_df, cursor)

    # Stream CSV directly into Postgres
    with open(path, 'r', encoding='utf-8') as f:
        cursor.copy_expert(f"""
            COPY {table_name}
            FROM STDIN
            WITH CSV HEADER
            DELIMITER ','
            QUOTE '"'
        """, f)

    conn.commit()
    cursor.close()
    conn.close()


# def load_csv_to_postgres(table_name, filename):
#     path = os.path.join(CSV_DIR, filename)
#     df = pd.read_csv(path)
#
#     conn = get_postgres_conn()
#     cursor = conn.cursor()
#
#     create_table_if_not_exists(table_name, df, cursor)
#
#     placeholders = ', '.join(['%s'] * len(df.columns))
#     columns = ', '.join(f'"{col}"' for col in df.columns)
#     insert_query = f'INSERT INTO {table_name} ({columns}) VALUES ({placeholders})'
#     data = list(df.itertuples(index=False, name=None))
#     batch_size = 10000
#     for start in range(0, len(data), batch_size):
#         batch = data[start:start + batch_size]
#         cursor.executemany(insert_query, batch)
#     # for row in df.itertuples(index=False, name=None):
#     #     cursor.execute(insert_query, row)
#
#     conn.commit()
#     cursor.close()
#     conn.close()
