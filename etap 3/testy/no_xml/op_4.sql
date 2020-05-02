BEGIN;

SAVEPOINT save;

DO $do$
DECLARE 
	old_title text := (select title from film where film_id = 1);
BEGIN
	UPDATE film SET title = 'New title' where film_id = 1;
	insert into film_change_history (film_id, field_name, old_value, new_value) VALUES (1, 'title', old_title, 'New title');
END $do$;

ROLLBACK TO SAVEPOINT save;

COMMIT;