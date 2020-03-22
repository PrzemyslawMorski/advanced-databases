from dataclasses import dataclass

from .idGenerator import IdGenerator
from .randomNumberGenerator import RandomNumberGenerator


@dataclass
class Payment:
    payment_id: str
    customer_id: str
    staff_id: str
    rental_id: str
    amount: str
    payment_date: str

    def generate(staffs, rentals, number, self=None):
        entities = []
        random = RandomNumberGenerator()
        for i in range(0, number):
            staff_id = staffs[random.getGaussianListRand(staffs)].staff_id
            rental = rentals[i]
            customer_id = rental.customer_id
            entities.append(Payment(payment_id=IdGenerator.getId(),
                                    customer_id=customer_id,
                                    staff_id=staff_id,
                                    rental_id=rental.rental_id,
                                    amount=random.getintRandom(50) + 1,
                                    payment_date="2007-02-16 14:00:38.996577")
                            )
        return entities
