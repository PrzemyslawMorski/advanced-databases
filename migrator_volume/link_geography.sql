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
ALTER TABLE public.country ADD COLUMN borders geography(POLYGON);



-- city
ALTER TABLE public.city ADD COLUMN borders geography(POLYGON);

-- address
ALTER TABLE public.address ADD COLUMN location geography(POINT);
    
-- film
ALTER TABLE public.film ADD COLUMN film_shoot_locations geography(MULTIPOINT);

-- store
ALTER TABLE public.store ADD COLUMN area_of_influence geography(POLYGON);
