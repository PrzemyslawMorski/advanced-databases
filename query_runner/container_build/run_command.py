#!/usr/bin/python

import os
import psycopg2
from timeit import default_timer as timer

hostname = os.environ['DB_HOSTNAME']
username = os.environ['DB_USER']
password = os.environ['DB_PASSWORD']
database = os.environ['DB_DATABASE_NAME']
query_file = os.environ['DB_QUERY_FILE']
num_tests = int(os.environ['DB_NUM_TESTS'])

def measure_performance(connection, query):
    sum_execution_time = 0
    for _ in range(num_tests):
        cur = connection.cursor()
        start = timer()
        cur.execute(query)
        end = timer()
        sum_execution_time += (end - start)
    return sum_execution_time / num_tests


with open(query_file, 'r') as content_file:
    connection = psycopg2.connect(
        host=hostname, user=username, password=password, dbname=database)
    avg_execution_time = measure_performance(connection, content_file.read())
    print('AVERAGE EXECUTION TIME FOR', num_tests,
          'TESTS:', avg_execution_time, 's')
    connection.close()
