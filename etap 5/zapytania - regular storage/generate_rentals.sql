BEGIN;

SAVEPOINT save;

insert into
    rental (
        rental_id,
        rental_date,
        inventory_id,
        customer_id,
        return_date,
        staff_id
    )
select
    generated,
    (
        select
            NOW() + (random() * (NOW() + '90 days' - NOW())) + '30 days'
    ),
    1
    , (
        select
            customer_id
        from
            customer
        order by
            random()
        limit
            1
    ), (
        select
            NOW() + (random() * (NOW() + '90 days' - NOW())) + '30 days'
    ),
    1
from
    generate_series(300000, 340000) as generated;

ROLLBACK TO SAVEPOINT save;

COMMIT;