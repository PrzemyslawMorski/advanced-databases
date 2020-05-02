BEGIN;

SAVEPOINT save;

UPDATE
    rental
SET
    staff_id = null
FROM
    rental r
    left outer join staff c on r.staff_id = c.staff_id
WHERE
    r.rental_date < '2015-02-01 08:43:49'
    and first_name like 'Geo%'
    and last_name like 'Dut%'
    and email like 'gdutson2br%'
    and email like '%moonfruit%'
    and email like '%.com';

UPDATE
    payment
SET
    staff_id = null
FROM
    payment p
    left outer join staff c on p.staff_id = c.staff_id
WHERE
    first_name like 'Geo%'
    and last_name like 'Dut%'
    and email like 'gdutson2br%'
    and email like '%moonfruit%'
    and email like '%.com';

delete from
    staff
where
    first_name like 'Geo%'
    and last_name like 'Dut%'
    and email like 'gdutson2br%'
    and email like '%moonfruit%'
    and email like '%.com';

ROLLBACK TO SAVEPOINT save;

COMMIT;