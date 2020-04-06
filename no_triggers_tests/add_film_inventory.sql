BEGIN;

SAVEPOINT save;

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
    film_category (film_id, category_id)
values
    (706001, 1);

insert into
    film_category (film_id, category_id)
values
    (706001, 3);
    
insert into
    film_category (film_id, category_id)
values
    (706001, 5);

insert into
    inventory (inventory_id, film_id, store_id)
values
    (707000, 706001, 1),
    (707001, 706001, 1),
    (707002, 706001, 1),
    (707003, 706001, 1),
    (707004, 706001, 1),
    (707005, 706001, 1),
    (707006, 706001, 1),
    (707007, 706001, 1),
    (707008, 706001, 1),
    (707009, 706001, 1),
    (707010, 706001, 2),
    (707011, 706001, 2),
    (707012, 706001, 2),
    (707013, 706001, 2),
    (707014, 706001, 2),
    (707015, 706001, 2),
    (707016, 706001, 2),
    (707017, 706001, 2),
    (707018, 706001, 2),
    (707019, 706001, 2),
    (707020, 706001, 2),
    (707021, 706001, 2),
    (707022, 706001, 3),
    (707023, 706001, 3),
    (707024, 706001, 3),
    (707025, 706001, 3),
    (707026, 706001, 3),
    (707027, 706001, 3),
    (707028, 706001, 3);

ROLLBACK TO SAVEPOINT save;

COMMIT;