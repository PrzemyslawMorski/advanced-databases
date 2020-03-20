with film_rentals_with_avg_rentals as (
    with avg_film_rentals as (
        with film_rentals as (
            select
                count(r.rental_id) as num_rentals
            from
                film f
                left outer join inventory i on f.film_id = i.film_id
                left outer join rental r on i.inventory_id = r.inventory_id
            group by
                f.film_id
        )
        select
            avg(num_rentals) as average_rentals_per_movie
        from
            film_rentals
    )
    select
        count(r.rental_id) as num_rentals,
        title,
        (
            select
                *
            from
                avg_film_rentals
        )
    from
        film f
        left outer join inventory i on f.film_id = i.film_id
        left outer join rental r on i.inventory_id = r.inventory_id
    group by
        f.film_id
)
select
    title,
    num_rentals
from
    film_rentals_with_avg_rentals
where
    num_rentals >= average_rentals_per_movie