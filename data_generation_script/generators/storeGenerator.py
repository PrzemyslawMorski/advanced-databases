from dataclasses import dataclass

from mockDataReader import MockDataReader
from .idGenerator import IdGenerator
from .randomNumberGenerator import RandomNumberGenerator


@dataclass
class Store:
    store_id: str
    manager_staff_id: str
    address_id: str
    last_update: str

    def generate(addresses, managers, self=None):
        entities = []
        reader = MockDataReader()
        random = RandomNumberGenerator()
        for i in range(0, len(managers)):
            row = reader.getRow()
            manager = managers[i]
            storeId = IdGenerator.getId()
            manager.store_id = storeId
            managerId = manager.staff_id
            entities.append(Store(store_id=storeId,
                                  manager_staff_id=managerId,
                                  address_id=addresses[i].address_id,
                                  last_update="2006-02-15 09:45:30")
                            )
        return entities
