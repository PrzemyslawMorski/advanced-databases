BEGIN;

SAVEPOINT save;

DO
$do$
BEGIN 
   FOR j IN 1..5000 LOOP

    -- rule 1
	IF (select count(customer_id) from customer where customer_id = 1 and activebool = 'f') = 1
   THEN
      RAISE EXCEPTION 'Sorry, you cannot rent as a non-active user';
   END IF;

    -- rule 2
   	IF (select count(customer_id) from customer where customer_id = 1 and date_part('year',age(CURRENT_DATE, create_date)) < 1) = 1 and   
   (SELECT count(r.rental_id) FROM public.rental r join public.customer c on r.customer_id = c.customer_id where c.customer_id = 1 and 
		r.return_date is null) > 3
   THEN
      RAISE EXCEPTION 'Sorry, as a new user you cannot rent more than 3 films';
   END IF;

insert into
    rental (
        rental_id,
        rental_date,
        inventory_id,
        customer_id,
        staff_id
    )
values
    (
        406000 + j,
        '2015-05-24 12:54:33',
        1,
        1,
        1
    );

insert into
    payment (
        payment_id,
        customer_id,
        staff_id,
        rental_id,
        amount
    )
values
    (
        406000 + j,
        1,
        1,
        406000 + j,
        100
    );

-- rule 7
	UPDATE film SET rental_rate = rental_rate + 0.01 WHERE film_id in (
        SELECT DISTINCT f.film_id 
        FROM film f 
        JOIN inventory i ON f.film_id = i.film_id 
        JOIN rental r ON r.inventory_id = i.inventory_id 
        WHERE r.rental_id = (406000 + j)
    );

    -- rule 4
   IF (SELECT count(p.payment_id) FROM public.payment p where customer_id = 1) % 10 = 0 THEN
		UPDATE payment SET amount = amount * 0.90 WHERE payment_id = 406000 + j;
	END IF;

   END LOOP;
END
$do$;

ROLLBACK TO SAVEPOINT save;

COMMIT;