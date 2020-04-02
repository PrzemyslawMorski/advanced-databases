SELECT
    DISTINCT f.film_id,
    f.rental_rate
FROM
    film f
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON r.inventory_id = i.inventory_id
WHERE
    r.rental_id = 405000;

SELECT
    DISTINCT f.film_id,
    f.rental_rate
FROM
    film f
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON r.inventory_id = i.inventory_id
WHERE
    r.rental_id = 405000;

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
        405001,
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
    (707000, 405001, 1);

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
        405001,
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
        406010,
        '2015-05-24 12:54:33',
        707000,
        405001,
        1
    );