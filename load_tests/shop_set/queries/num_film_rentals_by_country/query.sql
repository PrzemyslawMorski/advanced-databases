with film_rentals_by_country as (
    select
        f.film_id,
        count(*) as num_rentals,
        ctry.country_id
    from
        film f
        left outer join inventory i on f.film_id = i.film_id
        left outer join rental r on i.inventory_id = r.inventory_id
        left outer join customer cr on r.customer_id = cr.customer_id
        left outer join address ad on cr.address_id = ad.address_id
        left outer join city ct on ad.city_id = ct.city_id
        left outer join country ctry on ct.country_id = ctry.country_id
    group by
        f.film_id,
        ctry.country_id
)
select
    title as film_title,
    frc.num_rentals as num_rentals,
    c.country as country
from
    film_rentals_by_country frc
    left outer join film f on frc.film_id = f.film_id
    left outer join country c on frc.country_id = c.country_id
order by
    film_title asc,
    num_rentals desc