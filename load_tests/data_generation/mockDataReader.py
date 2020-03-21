class MockDataReader:

    rowId = 0

    data = None

    first_name = 0
    last_name = 1
    email = 2
    gender = 3
    date = 4
    time = 5
    address = 6
    state = 7
    postalCode = 8
    phone = 9
    city = 10
    login = 11
    password = 12
    year = 13

    def __init__(self):
        if MockDataReader.data is None:
            self.readCSV()

    def readCSV(self):
        with open("data.csv") as f:
            self.data = f.readlines()

    def get(self):
        return MockDataReader.data

    def getRow(self):
        MockDataReader.rowId = MockDataReader.rowId + 1
        return self.data[MockDataReader.rowId].split(',')


