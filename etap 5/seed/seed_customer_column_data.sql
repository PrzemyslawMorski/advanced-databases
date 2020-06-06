DROP TABLE IF EXISTS customer_column_storage;

select *
into customer_column_storage
from (
	select 
		c.customer_id,
		store_id,
		first_name,
		last_name,
		email,
		activebool,
		ad.address, 
		ad.district, 
		ad.phone, 
		ad.postal_code,
		ct.city,	
		ctry.country
	from customer c
		join address ad on c.address_id = ad.address_id
		join city ct on ad.city_id = ct.city_id
		join country ctry on ct.country_id = ctry.country_id
) as customer_data;

ALTER TABLE customer_column_storage ADD PRIMARY KEY (customer_id);
ALTER TABLE customer_column_storage ADD CONSTRAINT FK_Store FOREIGN KEY (store_id) REFERENCES store(store_id);
