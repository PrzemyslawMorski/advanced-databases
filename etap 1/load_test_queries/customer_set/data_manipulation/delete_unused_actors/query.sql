BEGIN;

SAVEPOINT save;

delete from
    actor a
where
    a.actor_id not in (
        select
            actor_id
        from
            film_actor
    );

ROLLBACK TO SAVEPOINT save;

COMMIT;