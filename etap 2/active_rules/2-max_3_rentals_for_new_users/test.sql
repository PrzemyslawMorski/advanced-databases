insert into
    customer (
        customer_id,
        store_id,
        first_name,
        last_name,
        email,
        address_id,
        activebool,
        create_date,
        active
    )
values
    (
        400000,
        1,
        'Jaredd',
        'Elyy',
        'jaredd.elyy@sakilacustomer.org',
        530,
        't',
        '2020-02-14',
        1
    );

insert into
    rental (
        rental_id,
        rental_date,
        inventory_id,
        customer_id,
        staff_id
    )
values
    (
        400001,
        '2015-05-24 22:54:33',
        1526,
        400000,
        1
    ),
    (
        400002,
        '2015-05-25 22:54:33',
        1526,
        400000,
        1
    ),
    (
        400003,
        '2015-05-26 22:54:33',
        1526,
        400000,
        1
    );

insert into
    rental (
        rental_id,
        rental_date,
        inventory_id,
        customer_id,
        staff_id
    )
values
    (
        400004,
        '2015-05-29 22:54:33',
        1527,
        400000,
        1
    );