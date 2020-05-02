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
END IF;
   END LOOP;
END
$do$;

ROLLBACK TO SAVEPOINT save;

COMMIT;