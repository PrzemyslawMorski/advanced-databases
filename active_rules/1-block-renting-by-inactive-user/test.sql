insert into
    film (
        film_id,
        title,
        description,
        release_year,
        language_id,
        rental_duration,
        rental_rate,
        length,
        replacement_cost,
        rating,
        last_update,
        special_features
    )
values
    (
        706001,
        'Chamber Italian',
        'A Fateful Reflection of a Moose And a Husband who must Overcome a Monkey in Nigeria',
        2006,
        1,
        7,
        4.99,
        117,
        14.99,
        'NC-17',
        '2013-05-26 14:50:58.951',
        '{Trailers}'
    );

insert into
    inventory (inventory_id, film_id, store_id)
values
    (706001, 706001, 1);

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
        706001,
        1,
        'Jareddd',
        'Elyyy',
        'jareddd.elyyy@sakilacustomer.org',
        530,
        'f',
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
        706001,
        '2015-05-24 12:54:33',
        706001,
        706001,
        1
    );



select * from customer where customer_id = 706001;