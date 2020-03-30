#!/usr/bin/python

import subprocess
import os


def run_test(query_path, num_tests):
    os.system('run_query.py ' + query_path + ' ' + str(num_tests))


# setup
output = subprocess.Popen(['docker-compose', 'run', 'migrator'])
subprocess.Popen.wait(output)

# set - customer

# queries

# /dvdrental/load_test_queries/customer_set/queries/movies_rented_more_than_average/query.sql
print('Running: load_test_queries/customer_set/queries/movies_rented_more_than_average/query.sql')

run_test(os.path.join(
    'load_test_queries', 'customer_set', 'queries', 'movies_rented_more_than_average', 'query.sql'), 10)

# /dvdrental/load_test_queries/customer_set/queries/num_rentals_by_release_year/query.sql

# /dvdrental/load_test_queries/customer_set/queries/rentals_from_a_city/query.sql

# data manipulation

# /dvdrental/load_test_queries/customer_set/data_manipulation/delete_movie/query.sql

# /dvdrental/load_test_queries/customer_set/data_manipulation/delete_unused_categories/query.sql

# set - rentals


# set - store
