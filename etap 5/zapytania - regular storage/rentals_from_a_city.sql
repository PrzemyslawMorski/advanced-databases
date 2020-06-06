select
	c.city,
	f.title
from
	rental r
	left outer join inventory i on i.inventory_id = r.inventory_id
	left outer join film f on f.film_id = i.film_id
	left outer join customer cust on cust.customer_id = r.customer_id
	left outer join address ad on cust.address_id = ad.address_id
	left outer join city c on c.city_id = ad.city_id
order by city, title;