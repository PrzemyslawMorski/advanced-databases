from dataclasses import dataclass

from mockDataReader import MockDataReader
from .idGenerator import IdGenerator
from .randomNumberGenerator import RandomNumberGenerator


@dataclass
class Rental:
    rental_id: str
    rental_date: str
    inventory_id: str
    customer_id: str
    return_date: str
    staff_id: str
    last_update: str

    def generate(inventories, customers, staffs, number, self=None):
        entities = []
        random = RandomNumberGenerator()
        reader = MockDataReader()
        for i in range(0, number):
            row = reader.getRow()
            inventory_id = inventories[random.getGaussianListRand(inventories)].inventory_id
            customer_id = customers[random.getGaussianListRand(customers)].customer_id
            staff_id = staffs[random.getGaussianListRand(staffs)].staff_id
            entities.append(Rental(rental_id=IdGenerator.getId(),
                                   rental_date=row[reader.date] + " " + row[reader.time],
                                   inventory_id=inventory_id,
                                   customer_id=customer_id,
                                   return_date="2005-05-24 22:54:33",
                                   staff_id=staff_id,
                                   last_update="2005-05-24 22:54:33")
                            )
        return entities
