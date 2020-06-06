select title, c.city
from customer_column_storage c
    join rental_column_storage r on c.customer_id = r.customer_id
order by c.city, title;
    