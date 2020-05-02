BEGIN;

SAVEPOINT save;

DELETE FROM actor a WHERE a.actor_id NOT IN (select distinct actor_id FROM film_actor);

ROLLBACK TO SAVEPOINT save;

COMMIT;