from dataclasses import dataclass
from .idGenerator import IdGenerator
from mockDataReader import MockDataReader


@dataclass
class Actor:
    actor_id: str
    first_name: str
    last_name: str
    last_update: str

    def generate(number, self=None):
        entities = []
        reader = MockDataReader()
        for i in range(0, number):
            row = reader.getRow()
            entities.append(Actor(actor_id=IdGenerator.getId(),
                                  first_name=row[reader.first_name],
                                  last_name=row[reader.last_name],
                                  last_update="2006-02-15 09:45:30"))
        return entities
