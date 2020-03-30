BEGIN;

SAVEPOINT save;

delete from
    staff
where
    staff_id = 2001;

ROLLBACK TO SAVEPOINT save;

COMMIT;