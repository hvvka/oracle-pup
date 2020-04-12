-- 1

CREATE TRIGGER delete_employees
AFTER INSERT ON airline
BEGIN
  DELETE (SELECT *
        FROM employee e
          INNER JOIN airline a ON a.id = e.airline_id
        WHERE e.employment_date < a.establishment_date);
END;

-- INSERT INTO AIRLINE (id, company, code, country, establishment_date) VALUES (3001, 'Raven', 'RA-47', 'Brazil', null);


-- 2

BEGIN
DBMS_SCHEDULER.CREATE_JOB (
   job_name             => 'add_flights',
   job_type             => 'PLSQL_BLOCK',
   job_action           => 'BEGIN 
INSERT INTO flight
(id, flight_number, destination_country, destination_city, 
 departure, arrival, passengers, status, delay, is_national, 
 plane_id, airport_id)
SELECT f.id+1, "123", "Brazil", "Campinas",
  SYSDATE, SYSDATE + 3, 123, "CONFIRMED", 0, 
  (CASE WHEN f.is_national = 0 THEN 1 ELSE 0 END),
  (SELECT MAX(id) FROM plane), 
  (SELECT MIN(id) FROM airport)
FROM flight f
WHERE f.id = (SELECT MAX(id) FROM flight); 
END;',
   start_date           => SYSTIMESTAMP,
   repeat_interval      => 'freq=hourly; byminute=0; bysecond=0;', 
   enabled              =>  TRUE,
   comments             => 'Add new flight every hour');
END;


-- 3

CREATE TRIGGER insert_employees
AFTER INSERT ON flight
BEGIN

  INSERT INTO employee 
  (id, 
   name, 
   surname, 
   birthdate, 
   gender, 
   occupation, 
   employment_date, 
   flown_hours, 
   airline_id)
  SELECT employee_id_seq.NEXTVAL, a, b, c, d, f, g, h, i
  FROM (SELECT MAX(e.name) a, 
               MIN(e.surname) b, 
               MEDIAN(birthdate) + 10 c,
               ROUND(AVG(CASE WHEN e.gender = 1 THEN 1 ELSE 0 END)) d,
               MIN(e.occupation) f,
               MEDIAN(employment_date) g,
               VARIANCE(flown_hours) / COUNT(*) h,
               e.airline_id i
        FROM employee e
        GROUP BY e.airline_id);

END;

-- INSERT INTO flight(id, flight_number, destination_country, destination_city, departure, arrival, passengers, status, delay, is_national, plane_id, airport_id) VALUES (30001, 'flight_number', 'destination_country', 'destination_city', to_date('2019-12-11 09:21:41', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-12-11 09:21:41', 'YYYY-MM-DD HH24:MI:SS'), 2137, 'status', 14.88, 0, 1, 1);


-- 4

CREATE TRIGGER update_flown_hours
AFTER UPDATE OF arrival ON flight
BEGIN

  UPDATE employee eu
  SET eu.flown_hours = (SELECT SUM(24 * (f.arrival - f.departure))
                     FROM flight f
                     JOIN flight_employee fe ON f.id = fe.flight_id
                     JOIN employee e ON e.id = fe.employee_id);

END;

-- UPDATE flight SET arrival = to_date('2019-12-11 09:21:41', 'YYYY-MM-DD HH24:MI:SS');


-- 5

CREATE TRIGGER add_flight_when
BEFORE INSERT ON 
FOR EACH ROW
  DECLARE max_passengers float;
BEGIN

  SELECT seat_count INTO max_passengers FROM plane
  WHERE :new.plane_id = plane.id;

  IF (max_passengers < :new.passengers)
    THEN raise_application_error(-20000, 'IOIOIOIO');
  END IF; 

END;
