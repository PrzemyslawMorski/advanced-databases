BEGIN;

SAVEPOINT save;

delete from payment p
	where p.payment_id in (
        select
            p.payment_id
        from
            payment p
            left outer join rental r on r.rental_id = p.rental_id
            join customer c on r.customer_id = c.customer_id
        where
			r.rental_date < '2015-02-01 08:43:49'
    );

delete from
    rental r
where
    r.rental_id in (
        select
            r.rental_id
        from
            rental r
            left outer join payment p on r.rental_id = p.rental_id
            join customer c on r.customer_id = c.customer_id
        where
			r.rental_date < '2015-02-01 08:43:49'
    );

ROLLBACK TO SAVEPOINT save;

COMMIT;