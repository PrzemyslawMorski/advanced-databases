#!/usr/bin/python

from pathlib import Path
import subprocess
import os
import glob
import sys


def restore_db():
    print('Restoring database...')
    output = subprocess.Popen(
        ['docker-compose', 'run', 'migrator'], stdout=subprocess.DEVNULL, stderr=subprocess.STDOUT)
    subprocess.Popen.wait(output)


def run_test(query_path, num_tests):
    print('Running: ' + query_path)
    os.system('run_query.py ' + query_path + ' ' + str(num_tests))


# setup
restore_db()

for path in glob.iglob('load_test_queries/**', recursive=True):
    if (Path(path).name.endswith('.sql')):
        run_test(path, 10)
