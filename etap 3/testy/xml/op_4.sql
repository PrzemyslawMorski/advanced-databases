BEGIN;

SAVEPOINT save;

DO $do$
BEGIN
FOR i IN 1..1000 LOOP

	UPDATE film 
	SET 
		title = 'New title ' || i,
		change_history_xml = REGEXP_REPLACE(
        	xmlroot(xmlElement(name changes,
                      xpath('/changes/change', change_history_xml)
                           || xmlElement(name change, xmlforest(
							   now() AS change_date,
                               'title' as field_name,
                               (select title from film where film_id = 1) as old_value,
                               'New title ' || i as new_value))
                  ), version '1.0')::text,
        '<element>|</element>',
        '', 'g')::xml
	WHERE film_id = 1;
END LOOP;

END $do$;

ROLLBACK TO SAVEPOINT save;

COMMIT;