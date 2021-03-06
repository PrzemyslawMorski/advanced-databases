from dataclasses import dataclass

from mockDataReader import MockDataReader
from .idGenerator import IdGenerator
from .randomNumberGenerator import RandomNumberGenerator


@dataclass
class City:
    city_id: str
    city: str
    country_id: str
    last_update: str

    def generate(number=1, self=None):
        entities = []
        reader = MockDataReader()
        random = RandomNumberGenerator()
        for i in range(0, number):
            row = reader.getRow()
            entities.append(City(city_id=IdGenerator.getId(),
                                 city=row[reader.city],
                                 country_id=random.getGaussianRand(108)+1,
                                 last_update="2006-02-15 09:45:30")
                            )
        return entities
