from dataclasses import dataclass

from mockDataReader import MockDataReader
from .idGenerator import IdGenerator
from .randomNumberGenerator import RandomNumberGenerator


@dataclass
class Customer:
    customer_id: str
    store_id: str
    first_name: str
    last_name: str
    email: str
    address_id: str
    activebool: str
    create_date: str
    last_update: str
    active: str

    def generate(addresses, stores, number, self=None):
        entities = []
        reader = MockDataReader()
        random = RandomNumberGenerator()
        for i in range(0, number):
            row = reader.getRow()
            isActive = random.flagRandom(0.95)
            store_id = stores[random.getGaussianListRand(stores)].store_id
            entities.append(Customer(customer_id=IdGenerator.getId(),
                                     store_id=store_id,
                                     first_name=row[reader.first_name],
                                     last_name=row[reader.last_name],
                                     address_id=addresses[random.getListRandom(addresses)].address_id,
                                     email=row[reader.email],
                                     active=Customer.isActiveBoolean(isActive),
                                     last_update="2006-02-15 09:45:30",
                                     activebool=isActive,
                                     create_date="2006-02-15 09:45:30")
                            )
        return entities

    def isActiveBoolean(isActive, self=None):
        if isActive == 't':
            return '1'
        return '0'
