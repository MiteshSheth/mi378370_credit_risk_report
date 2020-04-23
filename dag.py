# Sample DAG File
# Step 1: Import Module
import airflow
import yaml
import logging
import io
import os
import re
import csv
import subprocess
from subprocess import Popen, PIPE
# The DAG object; we'll need this to instantiate a DAG
from airflow import DAG
import datetime as dt
# Operators; we need this to operate!
from airflow.operators.python_operator import PythonOperator
from airflow.operators.bash_operator import BashOperator
from airflow.operators.hive_operator import HiveOperator

#------------Reading Config File---------------
CONFIG_FILE='config.yaml'

def read_config():
    with open('/home/cloudera/airflow/dags/config.yaml','r') as stream:
        return (yaml.safe_load(stream))

config = read_config()

#Step 2 : Default Arguments
default_args = {
    'owner': 'airflow',
   #'depends_on_past': False,
    'start_date': dt.datetime(2020, 4, 21),
   #'retries': 1,
   #'retry_delay': dt.timedelta(minutes=2)
}

# Step 3: Instantiate the DAG
dag_hive = DAG(dag_id=config['dag_id'],
                  #schedule_interval='* * * * *',
                   schedule_interval=None,
                   start_date=dt.datetime(2020, 4, 21))

Task_1 = HiveOperator(hql='Final_Task_1.hql',
                                          task_id='Create_table',
                                          hive_cli_conn_id=config['hive_connection'],
                                          schema= config['hive_schema'],
                                          params = { 'hive_schema': config['hive_schema'],'output_path': config['output_path']},
                                          dag=dag_hive)

Task_2 = HiveOperator(hql='Final_Task_2.hql',
                                          task_id='Load_table',
                                          hive_cli_conn_id=config['hive_connection'],
                                          schema= config['hive_schema'],
                                          params = { 'hive_schema': config['hive_schema'],'input_path': config['input_path']},
                                          dag=dag_hive)

Task_3 = HiveOperator(hql='Final_Task_3.hql',
                                          task_id='Harmonise_table',
                                          hive_cli_conn_id=config['hive_connection'],
                                          schema= config['hive_schema'],
                                          params = { 'hive_schema': config['hive_schema']},
                                          dag=dag_hive)

Task_4 = HiveOperator(hql='Final_Task_4.hql',
                                          task_id='Aggregate_table',
                                          hive_cli_conn_id=config['hive_connection'],
                                          schema= config['hive_schema'],
                                          params = { 'hive_schema': config['hive_schema']},
                                          dag=dag_hive)

Task_5 = HiveOperator(hql='Final_Task_5.hql',
                                          task_id='Summary_report',
                                          hive_cli_conn_id=config['hive_connection'],
                                          schema= config['hive_schema'],
                                          params = { 'hive_schema': config['hive_schema']},
                                          dag=dag_hive)

Task_1 >> Task_2 >> Task_3 >> Task_4 >> Task_5
