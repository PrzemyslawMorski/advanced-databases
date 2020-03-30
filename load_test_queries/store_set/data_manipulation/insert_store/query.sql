BEGIN;

SAVEPOINT save;

with inserted_stores as (
    insert into
        store (store_id, manager_staff_id, address_id)
    select
        generated,
        (
            select
                staff_id
            from
                staff
            order by
                random()
            limit
                1
        ), (
            select
                address_id
            from
                address
            order by
                random()
            limit
                1
        )
    from
        generate_series(300000, 340000) as generated returning *
)
insert into
    inventory(inventory_id, film_id, store_id)
select
    generated,
    (
        select
            film_id
        from
            film
        order by
            random()
        limit
            1
    ), (
        select
            store_id
        from
            store
        order by
            random()
        limit
            1
    )
from
    generate_series(500000, 540000) as generated;

ROLLBACK TO SAVEPOINT save;

COMMIT;