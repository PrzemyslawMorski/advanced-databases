BEGIN;

SAVEPOINT save;

DO
$do$
BEGIN 
   FOR i IN 1..16 LOOP
IF i <> 6 THEN
insert into
    film_category (film_id, category_id)
values
    (1, i);

UPDATE
    film
SET
    replacement_cost = replacement_cost * 0.99
WHERE
    film_id in (
        SELECT
            DISTINCT f.film_id
        FROM
            film f
            JOIN film_category fc ON f.film_id = fc.film_id
        WHERE
            fc.category_id = i
            and f.film_id <> 1
    );

END IF;
   END LOOP;
END
$do$;

ROLLBACK TO SAVEPOINT save;

COMMIT;