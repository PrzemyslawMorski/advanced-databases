BEGIN;

SAVEPOINT save;

delete from
    rental r
where
    r.rental_id in (
        select
            r.rental_id
        from
            rental r
            left outer join payment p on r.rental_id = p.rental_id
        where
            p.rental_id = null
    );

ROLLBACK TO SAVEPOINT save;

COMMIT;