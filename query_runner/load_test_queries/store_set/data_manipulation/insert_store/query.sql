insert into
    store (store_id, manager_staff_id, address_id)
select
    generated,
    (select staff_id from staff order by random() limit 1),
    (select address_id from address order by random() limit 1)
from
    generate_series(300000, 305000) as generated;

delete from store s where s.store_id >= 300000;