from dataclasses import dataclass
from .idGenerator import IdGenerator
from mockDataReader import MockDataReader
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
        for i in range(0, len(addresses)):
            row = reader.getRow()
            manager = managers[random.getGaussianListRand(managers)]
            storeId = IdGenerator.getId()
            manager.store_id = storeId
            managerId = manager.staff_id
            entities.append(Store(store_id=storeId,
                                  manager_staff_id=managerId,
                                  address_id=addresses[i].address_id,
                                  last_update=row[reader.date] + " " + row[reader.time])
                            )
        return entities
