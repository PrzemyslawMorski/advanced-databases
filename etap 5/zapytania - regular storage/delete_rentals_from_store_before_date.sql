BEGIN;

SAVEPOINT save;

delete from payment p
	where p.payment_id in (
        select
            p.payment_id
        from
            payment p
            left outer join rental r on r.rental_id = p.rental_id
			join staff st on st.staff_id = p.staff_id
			join store s on st.store_id = st.store_id
	    where
			s.store_id = 1 and
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
			join staff st on st.staff_id = r.staff_id
			join store s on st.store_id = st.store_id
        where
			s.store_id = 1 and
			r.rental_date < '2015-02-01 08:43:49'
    );

ROLLBACK TO SAVEPOINT save;

COMMIT;