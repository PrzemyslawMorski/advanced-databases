BEGIN;

SAVEPOINT save;

with staff_to_delete as (
    select
        s.staff_id
    from
        staff s
        join store st on st.store_id = s.store_id
        join address ad on st.address_id = ad.address_id
    where
        district LIKE 'Cal'
        and st.last_update < '2006-02-15 09:45:30'
)
update
    payment
set
    staff_id = null
where
    staff_id in (
        select
            *
        from
            staff_to_delete
    );

delete from
    staff
where
    staff_id in (
        select
            s.staff_id
        from
            staff s
            join store st on st.store_id = s.store_id
            join address ad on st.address_id = ad.address_id
        where
            district LIKE 'Cal'
            and st.last_update < '2006-02-15 09:45:30'
    );

delete from
    store
where
    store_id in (
        select
            store_id
        from
            store st
            join address ad on st.address_id = ad.address_id
        where
            district LIKE 'Cal'
            and st.last_update < '2006-02-15 09:45:30'
    );

ROLLBACK TO SAVEPOINT save;

COMMIT;