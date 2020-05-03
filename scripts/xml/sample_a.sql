-- ZESTAW A


-- 1 

SELECT SUM(CASE WHEN extractValue(value(f), '//Delay') > 0 THEN 1 ELSE 0 END) / COUNT(*)
FROM Flight_xml f
  JOIN Plane_xml p ON extractValue(value(p), '//@id') = extractValue(value(f), '//PlaneId')
  JOIN airline a ON a.id = extractValue(value(p), '//AirlineId')
  INNER JOIN flight_employee fe ON extractValue(value(f), '//@id') = fe.flight_id
  INNER JOIN employee e ON e.id = fe.employee_id
GROUP BY a.id;


-- 2

SELECT SUM(CASE WHEN e.gender = 1 THEN 1 ELSE 0 END) AS 'all flights (women)',
       SUM(CASE WHEN e.gender = 1 AND f.delay > 0 THEN 1 ELSE 0 END) AS 'delayed flights (women)', 
       SUM(CASE WHEN e.gender = 0 THEN 1 ELSE 0 END) AS 'all flights (men)', 
       SUM(CASE WHEN e.gender = 0 AND f.delay > 0 THEN 1 ELSE 0 END) AS 'delayed flights (men)'
FROM flight f
    INNER JOIN flight_employee fe ON f.id = fe.flight_id
    INNER JOIN employee e ON e.id = fe.employee_id;


-- 3

INSERT INTO flight
(id, flight_number, destination_country, destination_city, 
 departure, arrival, passengers, status, delay, is_national, 
 plane_id, airport_id)
VALUES
(30001, 'flight_number', 'destination_country', 'destination_city', 
to_date('2019-12-11 09:21:41', 'YYYY-MM-DD HH24:MI:SS'), 
to_date('2019-12-11 09:21:41', 'YYYY-MM-DD HH24:MI:SS'), 
1, 'status', 14.88, 0, 1, 1);

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


-- 4

UPDATE flight
SET arrival = to_date('2019-12-11 09:21:41', 'YYYY-MM-DD HH24:MI:SS');

UPDATE employee eu
SET eu.flown_hours = (SELECT SUM(24 * (sysdate + extractValue(value(f), '//Arrival') - extractValue(value(f), '//Departure') - sysdate)
                      FROM Flight_xml f
                      JOIN flight_employee fe ON extractValue(value(f), '//@id') = fe.flight_id
                      JOIN employee e ON e.id = fe.employee_id);


-- 5

DELETE (SELECT *
        FROM airline a
          JOIN employee e ON e.airline_id = a.id
        WHERE TRUNC(MONTHS_BETWEEN(sysdate, e.birthdate)/12) < 18);
