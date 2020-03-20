with store_payments_with_address_and_city as (
    with store_payments_with_address as (
        with store_payments as (
	        with staff_payments as (
		        select 
			        s.store_id,	
			        s.staff_id, 
			        sum(p.amount) as staff_sum_payments
		        from staff s
		        left outer join payment p
		        on s.staff_id = p.staff_id
		        group by s.staff_id
	        )
	        select 
		        s.store_id, 
		        s.address_id,
		        sum(staff_sum_payments) as store_payments
	        from store s
	        left outer join staff_payments sp
	        on s.store_id = sp.store_id
	        group by s.store_id
	        order by store_payments
        )
        select 
	        store_payments,
	        address,
	        address2,
	        district,
	        postal_code,
	        phone,      
	        city_id
        from store_payments sp
        left outer join address ad
        on sp.address_id = ad.address_id
    )
    select 
	    store_payments,
	    address,
	    address2,
	    district,
	    postal_code,
	    phone,
	    city,
	    country_id
    from store_payments_with_address spa
    left outer join city c
    on spa.city_id = c.city_id
)
select 
	store_payments,
	address,
	address2,
	district,
	postal_code,
	phone,
	city,
	country
from store_payments_with_address_and_city spac
left outer join country c
on spac.country_id = c.country_id
order by store_payments desc