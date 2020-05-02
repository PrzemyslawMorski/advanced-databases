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
        405000,
        1,
        'Jareddd',
        'Elyyy',
        'jareddd.elyyy@sakilacustomer.org',
        530,
        't',
        '2015-02-14',
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
        405010,
        '2015-05-24 12:54:33',
        1526,
        405000,
        1
    ),
    (
        405011,
        '2015-05-25 12:54:33',
        1527,
        405000,
        1
    ),
    (
        405012,
        '2015-05-26 12:54:33',
        1528,
        405000,
        1
    ),
    (
        405013,
        '2015-05-27 12:54:33',
        1529,
        405000,
        1
    ),
    (
        405014,
        '2015-05-28 12:54:33',
        1530,
        405000,
        1
    ),
    (
        405015,
        '2015-05-29 12:54:33',
        1531,
        405000,
        1
    ),
    (
        405016,
        '2015-05-30 12:54:33',
        1532,
        405000,
        1
    ),
    (
        405017,
        '2015-05-31 12:54:33',
        1533,
        405000,
        1
    ),
    (
        405018,
        '2015-06-1 12:54:33',
        1534,
        405000,
        1
    );

insert into
    payment (
        payment_id,
        customer_id,
        staff_id,
        rental_id,
        amount
    )
values
    (
        405010,
        405000,
        1,
        405010,
        100
    ),
    (
        405011,
        405000,
        1,
        405011,
        100
    ),
    (
        405012,
        405000,
        1,
        405012,
        100
    ),
    (
        405013,
        405000,
        1,
        405013,
        100
    ),
    (
        405014,
        405000,
        1,
        405014,
        100
    ),
    (
        405015,
        405000,
        1,
        405015,
        100
    ),
    (
        405016,
        405000,
        1,
        405016,
        100
    ),
    (
        405017,
        405000,
        1,
        405017,
        100
    ),
    (
        405018,
        405000,
        1,
        405018,
        100
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
        405019,
        '2015-06-02 12:54:33',
        1534,
        405000,
        1
    );

insert into
    payment (
        payment_id,
        customer_id,
        staff_id,
        rental_id,
        amount
    )
values
    (
        405010,
        405000,
        1,
        405010,
        100
    );