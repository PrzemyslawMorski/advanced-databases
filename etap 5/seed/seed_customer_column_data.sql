select *
into customer_column_data
from (
	select 
		c.customer_id,
		store_id,
		first_name,
		last_name,
		email,
		activebool,
		ad.address_id,
		ad.address, 
		ad.district, 
		ad.phone, 
		ad.postal_code, 
		ct.city_id,
		ct.city, 
		ctry.country_id,	
		ctry.country
	from customer c
		join address ad on c.address_id = ad.address_id
		join city ct on ad.city_id = ct.city_id
		join country ctry on ct.country_id = ctry.country_id
) as customer_data;
