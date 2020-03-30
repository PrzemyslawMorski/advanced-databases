#!/usr/bin/python

import os
import sys
import psycopg2
from timeit import default_timer as timer

hostname = 'localhost'
username = 'postgres'
password = 'password'
database = 'dvdrental'
query_file = sys.argv[1]
num_tests = int(sys.argv[2])

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
