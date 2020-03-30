#!/usr/bin/python

from pathlib import Path
import subprocess
import os
import glob
import sys
import psycopg2
from timeit import default_timer as timer

hostname = 'localhost'
username = 'postgres'
password = 'password'
database = 'dvdrental'
num_tests = 10


def restore_db():
    print('Restoring database...')
    output = subprocess.Popen(
        ['docker-compose', 'run', 'migrator'], stdout=subprocess.DEVNULL, stderr=subprocess.STDOUT)
    subprocess.Popen.wait(output)


def run_test(query_path, num_tests):
    print('Running: ' + query_path)
    with open(query_path, 'r') as content_file:
        query = content_file.read()

    connection = psycopg2.connect(
        host=hostname, user=username, password=password, dbname=database)

    sum_execution_time = 0
    for _ in range(num_tests):
        cur = connection.cursor()
        start = timer()
        cur.execute(query)
        end = timer()
        sum_execution_time += (end - start)

    avg_execution_time = sum_execution_time / num_tests
    print('AVERAGE EXECUTION TIME FOR', num_tests,
          'TESTS:', avg_execution_time, 's')

    connection.close()


# setup
restore_db()

for path in glob.iglob('load_test_queries/**', recursive=True):
    if (Path(path).name.endswith('.sql')):
        run_test(path, 10)
