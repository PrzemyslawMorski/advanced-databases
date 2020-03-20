with payments_by_store as (
	select
		st.store_id,
		sum(p.amount) as payments
	from
		store s
		left outer join staff st on s.store_id = st.store_id
		left outer join payment p on st.staff_id = p.staff_id
	group by
		st.store_id
)
select
	ps.payments,
	address,
	address2,
	district,
	postal_code,
	city,
	country
from
	store s
	left outer join payments_by_store ps on s.store_id = ps.store_id
	left outer join address ad on s.address_id = ad.address_id
	left outer join city ct on ad.city_id = ct.city_id
	left outer join country ctry on ct.country_id = ctry.country_id