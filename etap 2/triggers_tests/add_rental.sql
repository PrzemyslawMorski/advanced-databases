BEGIN;

SAVEPOINT save;

DO
$do$
BEGIN 
   FOR i IN 1..5000 LOOP

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
        406000 + i,
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
        406000 + i,
        1,
        1,
        406000 + i,
        100
    );

   END LOOP;
END
$do$;

ROLLBACK TO SAVEPOINT save;

COMMIT;