-- ZESTAW A


-- 1 

SELECT SUM(CASE WHEN f.delay > 0 THEN 1 ELSE 0 END) / COUNT(*)
FROM flight f
  JOIN plane p ON p.id = f.plane_id
  JOIN airline a ON a.id = p.airline_id
  INNER JOIN flight_employee fe ON f.id = fe.flight_id
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
2137, 'status', 14.88, 0, 1, 1);


-- 4

UPDATE flight
SET arrival = to_date('2019-12-11 09:21:41', 'YYYY-MM-DD HH24:MI:SS');


-- 5

DELETE (SELECT *
        FROM airline a
          JOIN employee e ON e.airline_id = a.id
        WHERE TRUNC(MONTHS_BETWEEN(sysdate, e.birthdate)/12) < 18);
