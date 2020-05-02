BEGIN;

SAVEPOINT save;

DO $do$
BEGIN
FOR i IN 1..1000 LOOP
	UPDATE film SET title = 'New title' || i where film_id = 1;
	insert into film_change_history (film_id, field_name, old_value, new_value) 
	VALUES (1, 'title', (select title from film where film_id = 1), 'New title' || i);
END LOOP;
END $do$;

ROLLBACK TO SAVEPOINT save;

COMMIT;