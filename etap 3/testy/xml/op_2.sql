BEGIN;

SAVEPOINT save;

DO
$do$
BEGIN 

FOR i IN 2..9 LOOP

    -- update film.actors_xml
	UPDATE film 
	SET 
		actors_xml = REGEXP_REPLACE(
        	xmlroot(xmlElement(name actors,
                      xpath('/actors/actor', actors_xml)
                           || xmlElement(name actor, xmlforest(i as actor_id))
                  ), version '1.0')::text,
        '<element>|</element>',
        '', 'g')::xml
	WHERE film_id = 1;

    -- update actor.films_xml
    UPDATE actor 
	SET 
		films_xml = REGEXP_REPLACE(
        	xmlroot(xmlElement(name films,
                      xpath('/films/film', films_xml)
                           || xmlElement(name film, xmlforest(1 as film_id))
                  ), version '1.0')::text,
        '<element>|</element>',
        '', 'g')::xml
	WHERE actor_id = i;

END LOOP;

END
$do$;

ROLLBACK TO SAVEPOINT save;

COMMIT;