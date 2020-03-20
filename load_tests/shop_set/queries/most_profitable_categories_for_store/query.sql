with store_categories_by_profit as (
    select
        s.store_id,
        c.category_id,
        sum(p.amount) as payments
    from
        store s
        left outer join inventory i on s.store_id = i.store_id
        left outer join rental r on i.inventory_id = r.inventory_id
        left outer join payment p on r.rental_id = p.rental_id
        left outer join film f on i.film_id = f.film_id
        left outer join film_category fc on f.film_id = fc.film_id
        left outer join category c on fc.category_id = c.category_id
    group by
        s.store_id,
        c.category_id
)
select
    address,
    city,
    country,
    payments,
    c.name
from
    store s
    left outer join store_categories_by_profit scp on s.store_id = scp.store_id
    left outer join category c on c.category_id = scp.category_id
    left outer join address ad on s.address_id = ad.address_id
    left outer join city ct on ad.city_id = ct.city_id
    left outer join country ctry on ct.country_id = ctry.country_id
order by
    s.store_id,
    scp.payments desc