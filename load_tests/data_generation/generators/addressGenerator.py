from dataclasses import dataclass
from .idGenerator import IdGenerator
from mockDataReader import MockDataReader
from .randomNumberGenerator import RandomNumberGenerator


@dataclass
class Address:
    address_id: str
    address: str
    address2: str
    district: str
    city_id: str
    postal_code: str
    phone: str
    last_update: str

    def generate(cities, number, self=None):
        entities = []
        reader = MockDataReader()
        for i in range(0, number):
            row = reader.getRow()
            cityId = cities[RandomNumberGenerator().getGaussianListRand(cities)].city_id
            entities.append(Address(address_id=IdGenerator.getId(),
                                    address=row[reader.address],
                                    district=row[reader.state],
                                    city_id=cityId,
                                    postal_code="mockPostalCode",
                                    address2="",
                                    phone=row[reader.phone],
                                    last_update="2006-02-15 09:45:30"))
        return entities
