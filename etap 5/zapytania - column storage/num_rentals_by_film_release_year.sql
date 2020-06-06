select
    release_year,
    count(rental_id) as num_rentals
from rental_column_storage    
group by release_year