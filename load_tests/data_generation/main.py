import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
import requests
from time import time
import sys
import json
import csv
import logging
import re
from dataFetcher import DataFetcher
from csvWriter import CSVWriter

# LOGGING CONFIG
logging.basicConfig(filename="logs",
                            filemode='a',
                            format='%(asctime)s - %(name)s %(levelname)s %(message)s',
                            datefmt='%H:%M:%S',
                            level=logging.DEBUG)

logger = logging.getLogger('## app-log ##')
consoleHandler = logging.StreamHandler(sys.stdout)
consoleHandler.setLevel(logging.DEBUG)
logger.addHandler(consoleHandler)
logger.info("### APPLICAITON STARTING ###")
# LOGGING CONFIG

## APPLICATION CONFIG ##
RESULTS_CSV_FILE = "data.csv"
LINES_IN_REQUEST = 5000 # 5000 MAX
REQUESTS_COUNT = 2
DATA_GENERATE_URL = "https://api.mockaroo.com/api/1d0bd460?count={}&key=1cdc7d30".format(LINES_IN_REQUEST)
## APPLICATION CONFIG ##
ACTORS_COUNT=1000
CITIES_COUNT=1000



# try:
#dataFetcher = DataFetcher(RESULTS_CSV_FILE, REQUESTS_COUNT, LINES_IN_REQUEST, DATA_GENERATE_URL)
#dataFetcher.fetchData()
csvWriter = CSVWriter()
csvWriter.writeActors(ACTORS_COUNT)
csvWriter.writeCities(1000)
csvWriter.writeAddresses(10000)
csvWriter.writeStores(100)
csvWriter.writeStaff(1000)
logger.info("### APPLICAITON FINISHED ###")

# except Exception as e:
#     logger.error(e)

