from dataclasses import dataclass
from .idGenerator import IdGenerator
from mockDataReader import MockDataReader
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
                                 last_update=row[reader.date] + " " + row[reader.time])
                            )
        return entities
