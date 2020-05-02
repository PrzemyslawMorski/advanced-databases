with year_rentals as (
	select 
			unnest(xpath('/rentals/rental/rental_id/text()', rentals_xml)) as rentals,
			year 
		from rentals_by_year
		where xpath_exists('/rentals/rental', rentals_xml)
)
select count(*) as num_rentals, year from year_rentals group by year; 
