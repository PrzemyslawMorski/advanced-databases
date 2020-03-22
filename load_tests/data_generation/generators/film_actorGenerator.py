from dataclasses import dataclass

from .randomNumberGenerator import RandomNumberGenerator


@dataclass
class FilmActor:
    actor_id: str
    film_id: str
    last_update: str

    def generate(films, actors, self=None):
        entities = []
        random = RandomNumberGenerator()
        for film in films:
            actorIndexes= set()
            for i in range(0, random.getintRandom(9) + 1):
                index = random.getintRandom(len(actors)-1)
                actorIndexes.add(index)
            for actorIndex in actorIndexes:
                entities.append(FilmActor(actor_id=actors[actorIndex].actor_id,
                                          film_id=film.film_id,
                                          last_update="2013-05-26 14:47:57.62")
                                )
        return entities
