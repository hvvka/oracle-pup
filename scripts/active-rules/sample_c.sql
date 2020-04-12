-- ZESTAW C


-- 1 

SELECT AVG(TRUNC((sysdate - e.birthdate) / 365)) AS 'average employee age'
FROM employee e 
  JOIN flight_employee fe ON e.id = fe.employee_id
  JOIN flight f ON fe.flight_id = f.id
WHERE f.delay > 5.0 AND f.delay < 10.0;


-- 2

SELECT a.company, SUM(TO_NUMBER(f.arrival - f.departure))
FROM airline a
  JOIN plane p ON a.id = p.airline_id
  JOIN flight f ON p.id = f.plane_id
WHERE f.departure = (SELECT MAX(departure) FROM flight)
GROUP BY a.company;


-- 3

INSERT INTO plane (id, 
                   manufacturer, 
                   model, 
                   production_date, 
                   seat_count, 
                   fuel_capacity, 
                   cruising_range, 
                   airline_id)
SELECT plane_id_seq.NEXTVAL, a, b, c, d, e, f, g
FROM (SELECT p.manufacturer a, 
             p.model b, 
             p.production_date c, 
             p.seat_count d, 
             p.fuel_capacity e, 
             p.cruising_range f, 
             p.airline_id g 
      FROM plane p
      ORDER BY TRUNC(p.fuel_capacity) / p.cruising_range
      FETCH NEXT 5 ROWS ONLY);


-- 4

UPDATE airline
SET establishment_date = (SELECT MIN(f.departure)
                          FROM flight f
                          JOIN plane p ON p.id = f.plane_id
                          JOIN airline a ON a.id = p.airline_id);


-- 5

INSERT INTO AIRLINE (id, company, code, country, establishment_date) 
VALUES (3001, 'Raven', 'RA-47', 'Brazil', null);
