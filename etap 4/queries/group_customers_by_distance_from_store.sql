select customer_id, first_name, last_name, floor(ST_Distance(
	(select location from address ad join store st on ad.address_id = st.address_id where store_id = 1),
	ad.location
) / 10000)::int as distance_group_from_store
from customer c join address ad on c.address_id = ad.address_id
order by distance_group_from_store;
