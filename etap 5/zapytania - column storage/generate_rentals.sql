BEGIN;

SAVEPOINT save;
insert into
    rental_column_storage (
		rental_id, 
        rental_date,
		customer_id,
		first_name,
		email,
		address,
		city,
		country,
		title,
		description,
		release_year 
    )
select
-- rental_id
    generated,
-- rental_date
    (
        select
            NOW() + (random() * (NOW() + '90 days' - NOW())) + '30 days'
    ),
-- 	customer_id
	(
        select
            customer_id
        from
            customer
        order by
            random()
        limit
            1
    ),
-- s.first_name, 
'Tomasz',
-- s.email, 
'morskiprzemyslaw@zbd.com',
-- a.address,
'Plac Grunwaldzki 5',
-- c.city, 
'Wroclaw',
-- country.country,
'Polska',
-- f.title, 
'Jon travolta',
-- f.description, 
'Bardzo fajny film',
-- f.release_year 
(
floor(random() * 20 + 2020)
)
from
    generate_series(300000, 340000) as generated;

ROLLBACK TO SAVEPOINT save;

COMMIT;