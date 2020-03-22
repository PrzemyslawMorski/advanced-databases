from dataclasses import dataclass

from mockDataReader import MockDataReader
from .idGenerator import IdGenerator
from .randomNumberGenerator import RandomNumberGenerator


@dataclass
class Film:
    film_id: str
    title: str
    description: str
    release_year: str
    language_id: str
    rental_duration: str
    rental_rate: str
    length: str
    replacement_cost: str
    rating: str
    last_update: str
    special_features: str
    fulltext: str

    # category ids: 1-16
    # language ids: 1-6
    def generate(number, self=None):
        entities = []
        reader = MockDataReader()
        random = RandomNumberGenerator()
        for i in range(0, number):
            row = reader.getRow()
            entities.append(Film(film_id=IdGenerator.getId(),
                                 title=row[reader.login],
                                 description=row[reader.first_name] + row[reader.password],
                                 release_year=row[reader.year],
                                 language_id=random.getintRandom(5) + 1,
                                 rental_duration=random.getintRandom(10) + 1,
                                 rental_rate=random.getintRandom(5) + 1,
                                 length=random.getintRandom(200) + 1,
                                 replacement_cost=random.getintRandom(50) + 1,
                                 rating="NC-17",
                                 last_update='2013-05-26 14:50:58.951',
                                 special_features="{Trailers}",
                                 fulltext=row[reader.password] + row[reader.login])
                            )
        return entities
