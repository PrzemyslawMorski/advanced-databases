BEGIN;

SAVEPOINT save;

delete from
    rental_column_storage r
where
    r.rental_id in (
        select
            r.rental_id
        from
            rental_column_storage r
		where
			address = '47 MySakila Drive' and
			city = 'Lethbridge' and
			rental_date < '2015-02-01 08:43:49'
    );

ROLLBACK TO SAVEPOINT save;

COMMIT;