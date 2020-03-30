select
    f.release_year,
    count(r.rental_id) as num_rentals
from
    film f
    left outer join inventory i on i.film_id = f.film_id
    left outer join rental r on i.inventory_id = r.inventory_id
group by
    f.release_year