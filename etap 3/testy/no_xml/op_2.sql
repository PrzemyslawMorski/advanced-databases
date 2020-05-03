BEGIN;

SAVEPOINT save;

DO
$do$
BEGIN 

FOR i IN 1..5000 LOOP
   INSERT INTO film_actor (film_id, actor_id) VALUES (1,i);
END LOOP;

END
$do$;

ROLLBACK TO SAVEPOINT save;

COMMIT;