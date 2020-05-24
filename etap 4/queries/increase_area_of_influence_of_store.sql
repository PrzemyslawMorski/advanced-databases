with expand_by as (
	with area_of_influence as (
		select area_of_influence from store where store_id = 1
	)
	SELECT radius * 0.1 FROM ST_MinimumBoundingRadius((select area_of_influence::geometry from area_of_influence))
)
update store
set area_of_influence = ST_MinimumBoundingCircle(ST_Expand(area_of_influence::geometry, (select * from expand_by)))
where store_id = 1;

select area_of_influence from store where store_id = 1;