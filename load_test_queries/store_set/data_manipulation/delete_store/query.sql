BEGIN;

SAVEPOINT save;

delete from
    store;

delete from
    staff;

ROLLBACK TO SAVEPOINT save;

COMMIT;