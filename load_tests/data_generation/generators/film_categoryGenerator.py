from dataclasses import dataclass

from .randomNumberGenerator import RandomNumberGenerator


@dataclass
class FilmCategory:
    film_id: str
    category_id: str
    last_update: str

    def generate(films, self=None):
        entities = []
        random = RandomNumberGenerator()
        for film in films:
            entities.append(FilmCategory(film_id=film.film_id,
                                         category_id=random.getintRandom(15) + 1,
                                         last_update="2006-02-15 09:45:30")
                            )
        return entities
