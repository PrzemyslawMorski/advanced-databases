from dataclasses import dataclass

from .idGenerator import IdGenerator
from .randomNumberGenerator import RandomNumberGenerator


@dataclass
class Inventory:
    inventory_id: str
    film_id: str
    store_id: str
    last_update: str

    def generate(films, stores, number, self=None):
        entities = []
        random = RandomNumberGenerator()
        for i in range(0, number):
            store_id = stores[random.getGaussianListRand(stores)].store_id
            film_id = films[random.getGaussianListRand(films)].film_id
            entities.append(Inventory(inventory_id=IdGenerator.getId(),
                                      film_id=film_id,
                                      store_id=store_id,
                                      last_update="2013-05-26 14:47:57.62")
                            )
        return entities
