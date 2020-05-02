BEGIN;

SAVEPOINT save;

UPDATE
    rental
SET
    customer_id = null
FROM
    rental r left outer join customer c on r.customer_id = c.customer_id
WHERE
    first_name like 'Jo%'
    and last_name like 'Ed%'
    and email like '%sakila%'
    and email like '%.org';
	
UPDATE
    payment
SET
    customer_id = null
FROM
    payment p left outer join customer c on p.customer_id = c.customer_id
WHERE
    first_name like 'Jo%'
    and last_name like 'Ed%'
    and email like '%sakila%'
    and email like '%.org';

delete from
    customer
where
    first_name like 'Jo%'
    and last_name like 'Ed%'
    and email like '%sakila%'
    and email like '%.org';

ROLLBACK TO SAVEPOINT save;

COMMIT;