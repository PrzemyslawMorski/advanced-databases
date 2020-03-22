import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
import requests
import logging
import re

class DataFetcher:

    def __init__(self,RESULTS_CSV_FILE, REQUEST_COUNT, LINES_IN_REQUEST, DATA_GENERATE_URL):
        self.RESULTS_CSV_FILE = RESULTS_CSV_FILE
        self.REQUEST_COUNT = REQUEST_COUNT
        self.DATA_GENERATE_URL = DATA_GENERATE_URL
        self.LINES_IN_REQUEST = LINES_IN_REQUEST
        self.logger = logging.getLogger('## app-log ##')

    def isEmptyFile(self, file):
        content = open(file, 'r').read()
        if re.search(r'^\s*$', content):
            return True

    def writeToFile(self, content):
        with open(self.RESULTS_CSV_FILE, 'a', encoding="utf-8") as f:
            fileIsEmpty = self.isEmptyFile(self.RESULTS_CSV_FILE)
            if not fileIsEmpty:
                index = content.find("\n")
                content = content[index + 1:]
            f.write(content)
            self.logger.info("SAVING RESULTS TO FILE")

    def fetchData(self):
        for i in range(0, self.REQUEST_COUNT):
            self.logger.info("request {}".format(i))
            r = requests.get(url=self.DATA_GENERATE_URL, verify=False)
            self.logger.info("received data:")
            data = r.content.decode("utf-8")
            print(data)
            self.writeToFile(data)
