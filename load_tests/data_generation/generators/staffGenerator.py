from dataclasses import dataclass
from .idGenerator import IdGenerator
from mockDataReader import MockDataReader
from .randomNumberGenerator import RandomNumberGenerator


@dataclass
class Staff:
    staff_id: str
    first_name: str
    last_name: str
    address_id: str
    email: str
    store_id: str
    active: str
    username: str
    password: str
    last_update: str
    picture: str

    def generate(addresses, stores, number, self=None):
        entities = []
        reader = MockDataReader()
        random = RandomNumberGenerator()
        for i in range(0, number):
            row = reader.getRow()
            storeId=0
            if stores is not None:
                storeId = stores[random.getGaussianListRand(stores)].store_id
            isActive = random.flagRandom(0.95)
            entities.append(Staff(staff_id=IdGenerator.getId(),
                                  first_name=row[reader.first_name],
                                  last_name=row[reader.last_name],
                                  address_id=addresses[random.getListRandom(addresses)].address_id,
                                  email=row[reader.email],
                                  store_id=storeId,
                                  active=isActive,
                                  last_update="2006-02-15 09:45:30",
                                  password="mockedPassword",
                                  picture=row[reader.password],
                                  username="mockedUsername")
                            )
        return entities
