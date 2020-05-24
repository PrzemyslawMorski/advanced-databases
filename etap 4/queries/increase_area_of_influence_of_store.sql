BEGIN;

SAVEPOINT save;

DO
$do$
BEGIN 

update store
set area_of_influence = ST_Scale(area_of_influence::geometry, 0.91, 0.91)
where store_id = 1;

select area_of_influence from store where store_id = 1;


END
$do$;

ROLLBACK TO SAVEPOINT save;

COMMIT;