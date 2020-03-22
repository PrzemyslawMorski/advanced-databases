from mockDataReader import MockDataReader

class ReaderFactory:
    def __init__(self):
        self.reader = None

    def getReader(self):
        if self.reader is None:
            self.reader = MockDataReader()
        return self.reader
