BEGIN;

SAVEPOINT save;

DELETE FROM actor a WHERE NOT xpath_exists('/films/film', a.films_xml);

ROLLBACK TO SAVEPOINT save;

COMMIT;