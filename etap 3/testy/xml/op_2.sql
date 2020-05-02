BEGIN;

SAVEPOINT save;

DO
$do$
BEGIN 

    INSERT INTO film_actor (film_id, actor_id) VALUES (1,3);
    INSERT INTO film_actor (film_id, actor_id) VALUES (1,5);
    INSERT INTO film_actor (film_id, actor_id) VALUES (1,7);
    INSERT INTO film_actor (film_id, actor_id) VALUES (1,11);
    INSERT INTO film_actor (film_id, actor_id) VALUES (1,13);
    INSERT INTO film_actor (film_id, actor_id) VALUES (1,15);
    INSERT INTO film_actor (film_id, actor_id) VALUES (1,17);
    INSERT INTO film_actor (film_id, actor_id) VALUES (1,21);
    INSERT INTO film_actor (film_id, actor_id) VALUES (1,23);
    INSERT INTO film_actor (film_id, actor_id) VALUES (1,25);

END
$do$;

ROLLBACK TO SAVEPOINT save;

COMMIT;