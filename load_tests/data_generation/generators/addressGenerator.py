from dataclasses import dataclass


@dataclass
class Address:
    address_id = None
    address = None
    address2 = None
    district = None
    city_id = None
    postal_code = None
    phone = None
    last_update = None