BEGIN;

SAVEPOINT save;

DO
$do$
BEGIN 
   FOR i IN 343000..353000 LOOP

   INSERT INTO film_actor (film_id, actor_id) VALUES (i,i-240000);

   END LOOP;
END
$do$;

ROLLBACK TO SAVEPOINT save;

COMMIT;