from airflow import DAG
from airflow.contrib.operators.gcs_to_bq import GoogleCloudStorageToBigQueryOperator
from airflow.contrib.operators.bigquery_operator import BigQueryOperator

from airflow.utils.dates import days_ago

default_arguments = {'owner': 'ludicxx', 'start_date':days_ago(1)}

with DAG(
    'bigquery_data_load', 
    schedule_interval='@hourly', 
    catchup=False, default_args=default_arguments) as dag:

    load_data = GoogleCloudStorageToBigQueryOperator(
        task_id='load_data',
        bucket='vg-logistics-landing-bucket',
        source_objects=['*'],
        source_format='CSV',
        skip_leading_rows=1,
        field_delimiter=',',
        destination_project_dataset_table='vg-airflow-tutorial-demo.vechicle_analytics.history',
        create_disposition='CREATE_IF_NEEDED',
        write_disposition='WRITE_APPEND',
        bigquery_conn_id='google_cloud_default',
        google_cloud_storage_conn_id='google_cloud_default',
    )
    # Select the latest data for each vehicle id
    query = '''
    SELECT * except (rank)
    FROM (
        SELECT *,
            ROW_NUMBER() OVER (
                PARTITION BY vehicle_id ORDER BY DATETIME(date, TIME(hour, minute, 0)) DESC
            ) as rank
        FROM `vg-airflow-tutorial-demo.vechicle_analytics.history`) as latest
    WHERE rank = 1;
    '''
    # Table to hold the latest data
    create_table = BigQueryOperator(
        task_id='create_table',
        sql=query,
        destination_dataset_table='vg-airflow-tutorial-demo.vechicle_analytics.latest',
        write_disposition='WRITE_TRUNCATE',
        create_disposition='CREATE_IF_NEEDED',
        use_legacy_sql=False,
        location='asia-south1',
        bigquery_conn_id='google_cloud_default'
    )

load_data >> create_table