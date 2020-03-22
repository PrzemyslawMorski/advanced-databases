import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
import sys
import logging
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
REQUESTS_COUNT = 10
DATA_GENERATE_URL = "https://api.mockaroo.com/api/1d0bd460?count={}&key=1cdc7d30".format(LINES_IN_REQUEST)
## APPLICATION CONFIG ##



try:
    dataFetcher = DataFetcher(RESULTS_CSV_FILE, REQUESTS_COUNT, LINES_IN_REQUEST, DATA_GENERATE_URL)
    dataFetcher.fetchData()
    csvWriter = CSVWriter()
    csvWriter.writeActors(1000)
    csvWriter.writeCities(10000)
    csvWriter.writeAddresses(100000)
    csvWriter.writeStores(1000)
    csvWriter.writeStaff(10000)
    csvWriter.writeActors(10000)
    csvWriter.writeStaff(10000)
    csvWriter.writeCustomers(100000)
    csvWriter.writeFilms(50000)
    csvWriter.writeInventories(100000)
    csvWriter.writeRentals(200000)
    csvWriter.writePayments(100000)
    logger.info("### APPLICAITON FINISHED ###")
except Exception as e:
    logger.error(e)

