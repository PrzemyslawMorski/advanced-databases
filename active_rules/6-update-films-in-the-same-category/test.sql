SELECT
    DISTINCT f.film_id,
    f.replacement_cost
FROM
    film f
    JOIN film_category fc ON f.film_id = fc.film_id
WHERE
    fc.category_id = 8
    and f.film_id <> 5
order by
    f.replacement_cost desc;

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
        405000,
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
    (405000, 8);