SAVEPOINT A;


-- 3 different column storage options for: plane_col and employee_col
alter table plane_col nomemory;
alter table plane_col inmemory;
alter table plane_col inmemory no inmemory
(ID, MANUFACTURER, PRODUCTION_DATE, SEAT_COUNT, FUEL_CAPACITY, CRUISING_RANGE, AIRLINE_COL_ID);

alter table employee_col nomemory;
alter table employee_col inmemory;
alter table employee_col inmemory no inmemory
(SURNAME, BIRTHDATE, GENDER, OCCUPATION, EMPLOYMENT_DATE, FLOWN_HOURS, AIRLINE_COL_ID);


-- operation 1
SELECT AVG(TRUNC((sysdate - e.birthdate) / 365)) AS "average employee age" FROM employee_col e JOIN flight_employee_col fe ON e.id = fe.employee_col_id JOIN flight_col f ON fe.flight_col_id = f.id WHERE f.delay > 5.0 AND f.delay < 10.0;
-- operation 2
SELECT a.company, SUM(TO_NUMBER(f.arrival - f.departure)) FROM airline_col a JOIN plane_col p ON a.id = p.airline_col_id JOIN flight_col f ON p.id = f.plane_col_id WHERE f.departure = (SELECT MAX(departure) FROM flight_col) GROUP BY a.company;
-- operation 3
INSERT INTO plane_col (id, manufacturer, model, production_date, seat_count, fuel_capacity, cruising_range, airline_col_id) SELECT plane_id_seq.NEXTVAL, a, b, c, d, e, f, g FROM (SELECT p.manufacturer a, p.model b, p.production_date c, p.seat_count d, p.fuel_capacity e, p.cruising_range f, p.airline_col_id g FROM plane_col p ORDER BY TRUNC(p.fuel_capacity) / p.cruising_range);


ROLLBACK TO A;
alter system flush buffer_cache;
alter system flush shared_pool;

