select
    c.city,
    ad.address,
    f.title,
    cus.first_name || ' ' || cus.last_name as customer_name,
    cus.email
from
    rental r
    left outer join inventory i on i.inventory_id = r.inventory_id
    left outer join film f on f.film_id = i.film_id
    left outer join store s on s.store_id = i.store_id
    left outer join address ad on s.address_id = ad.address_id
    left outer join city c on c.city_id = ad.city_id
    left outer join customer cus on r.customer_id = cus.customer_id