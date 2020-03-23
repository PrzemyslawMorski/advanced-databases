with city_store_rental as (
    select
        c.city_id,
        i.store_id,
        r.rental_id
    from
        rental r
        left outer join inventory i on i.inventory_id = r.inventory_id
        left outer join film f on f.film_id = i.film_id
        left outer join store s on s.store_id = i.store_id
        left outer join address ad on s.address_id = ad.address_id
        left outer join city c on c.city_id = ad.city_id
    group by
        c.city_id,
        i.store_id,
        r.rental_id
)
select
    city,
    address,
    title,
    first_name,
    last_name,
    email
from
    city_store_rental csr
    left outer join city c on csr.city_id = c.city_id
    left outer join store s on csr.store_id = s.store_id
    left outer join address ad on s.address_id = ad.address_id
    left outer join rental r on r.rental_id = csr.rental_id
    left outer join inventory i on r.inventory_id = i.inventory_id
    left outer join film f on i.film_id = f.film_id
    left outer join customer cust on cust.customer_id = r.customer_id
order by
    city,
    address,
    title