# import sys
# sys.path.insert(0, '/opt/airflow')
from load_data import load_csv_to_postgres
from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime

CSV_FILES = {
    'movies': 'movies.csv',
    'ratings': 'ratings.csv',
    'tags': 'tags.csv',
    'links': 'links.csv',
    'genome_tags': 'genome-tags.csv',
    'genome_scores': 'genome-scores.csv',
}

with DAG(
    dag_id='csv_ingestion_split_dag',
    start_date=datetime(2023, 1, 1),
    schedule=None,
    catchup=False,
    tags=['ingestion'],
) as dag:

    for table, file in CSV_FILES.items():
        PythonOperator(
            task_id=f'load_{table}',
            python_callable=load_csv_to_postgres,
            op_kwargs={'table_name': table, 'filename': file},
        )
