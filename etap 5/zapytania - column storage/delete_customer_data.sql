BEGIN;

SAVEPOINT save;

UPDATE
    rental_column_storage
SET
    customer_id = null
FROM
    rental_column_storage r left outer join customer_column_storage c on r.customer_id = c.customer_id
WHERE
    c.first_name like 'Jo%'
    and c.last_name like 'Ed%'
    and c.email like '%sakila%'
    and c.email like '%.org';

delete from
    customer_column_storage
where
    first_name like 'Jo%'
    and last_name like 'Ed%'
    and email like '%sakila%'
    and email like '%.org';

ROLLBACK TO SAVEPOINT save;

COMMIT;