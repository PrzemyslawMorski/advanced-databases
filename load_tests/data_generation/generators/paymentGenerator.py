from dataclasses import dataclass


@dataclass
class Payment:
    payment_id = None 
    customer_id = None 
    staff_id = None 
    rental_id = None 
    amount = None 
    payment_date = None 

