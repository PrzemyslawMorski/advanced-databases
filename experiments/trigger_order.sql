CREATE OR REPLACE FUNCTION public.logMessageA() RETURNS trigger
   LANGUAGE plpgsql AS
$$BEGIN
	raise notice 'Logging message from: A';
	RETURN NEW;
END;$$;

CREATE OR REPLACE FUNCTION public.logMessageB() RETURNS trigger
   LANGUAGE plpgsql AS
$$BEGIN
	raise notice 'Logging message from: B';
	RETURN NEW;
END;$$;

CREATE OR REPLACE FUNCTION public.logMessageC() RETURNS trigger
   LANGUAGE plpgsql AS
$$BEGIN
	raise notice 'Logging message from: C';
	RETURN NEW;
	
END;$$;
DROP TABLE IF EXISTS testTriggerTable;
CREATE TABLE testTriggerTable (
	id int
);

DROP TRIGGER IF EXISTS atrigger ON testTriggerTable;
CREATE TRIGGER atrigger AFTER INSERT
ON testTriggerTable
FOR EACH ROW
EXECUTE PROCEDURE logMessageA();


DROP TRIGGER IF EXISTS ctrigger ON testTriggerTable;
CREATE TRIGGER ctrigger BEFORE INSERT
ON testTriggerTable
FOR EACH ROW
EXECUTE PROCEDURE logMessageC();

DROP TRIGGER IF EXISTS btrigger ON testTriggerTable;
CREATE TRIGGER btrigger AFTER INSERT
ON testTriggerTable
FOR EACH ROW
EXECUTE PROCEDURE logMessageB();

INSERT into testTriggerTable values (1)