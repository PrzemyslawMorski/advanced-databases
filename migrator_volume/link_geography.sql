\connect dvdrental

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', 'public', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

CREATE EXTENSION if not exists postgis;
CREATE EXTENSION if not exists postgis_raster;
CREATE EXTENSION if not exists postgis_topology;
CREATE EXTENSION if not exists postgis_sfcgal;
CREATE EXTENSION if not exists fuzzystrmatch;
CREATE EXTENSION if not exists postgis_tiger_geocoder;
CREATE EXTENSION if not exists address_standardizer;

-- country
ALTER TABLE public.country ADD COLUMN borders geography(MULTIPOLYGON);
DO
$do$
DECLARE
	polish_geog geography = (SELECT geom FROM gadm36_pol_0 limit 1);
BEGIN 
  UPDATE public.country SET borders = polish_geog;
END
$do$;

-- city
ALTER TABLE public.city ADD COLUMN borders geography(MULTIPOLYGON);
DO
$do$
DECLARE 
  arow record;
BEGIN 
  FOR arow IN (SELECT * FROM public.city) LOOP
  	WITH random_city as (SELECT geom, name_2 FROM gadm36_pol_3 order by random() limit 1)
	  UPDATE public.city SET 
	  	borders = (select geom from random_city), 
		city = (select name_2 from random_city) 
	  WHERE city_id = arow.city_id;  
  END LOOP;
END
$do$ LANGUAGE plpgsql;

-- address
ALTER TABLE public.address ADD COLUMN location geography(POINT);
DO
$do$
DECLARE 
  arow record;
BEGIN 
  FOR arow IN (SELECT * FROM public.address) LOOP
  	WITH address_city as (
		SELECT ST_PointN(ST_MakeLine(ST_GeneratePoints(borders::geometry, 1)), 1) 
		FROM public.city 
		where city_id = arow.city_id
	)
	  UPDATE public.address SET 
	  	location = (SELECT * from address_city)
	  WHERE address_id = arow.address_id;  
  END LOOP;
END
$do$ LANGUAGE plpgsql;


-- film
ALTER TABLE public.film ADD COLUMN film_shoot_locations geography(LINESTRING);
DO
$do$
DECLARE 
  arow record;
BEGIN 
  FOR arow IN (SELECT * FROM public.film) LOOP
  	WITH random_points as (
		SELECT location
		FROM public.address 
    ORDER BY random()
    LIMIT 10
	)
	  UPDATE public.film SET 
	  	film_shoot_locations = ST_MakeLine(SELECT * from random_points)
	  WHERE film_id = arow.film_id;  
  END LOOP;
END
$do$ LANGUAGE plpgsql;


-- store
ALTER TABLE public.store ADD COLUMN area_of_influence geography(MULTIPOLYGON);
