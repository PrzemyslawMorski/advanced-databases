BEGIN;

SAVEPOINT save;

DO $do$
DECLARE 
	old_title text := (select title from film where film_id = 1);
BEGIN

END $do$;

ROLLBACK TO SAVEPOINT save;

COMMIT;