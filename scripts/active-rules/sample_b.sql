-- ZESTAW B


-- 1 

SELECT COUNT(*)
FROM flight f
  JOIN airport a ON a.id = f.airport_id
WHERE EXTRACT(MONTH FROM TRUNC(f.departure)) IN (1, 6) 
      AND a.longitude BETWEEN -73.98283055555555 AND -34.79314722222222;


-- 2

SELECT DISTINCT model
FROM plane p
  JOIN airline a ON a.id = p.airline_id
  JOIN employee e ON a.id = e.airline_id
WHERE SUBSTR(e.name, 1, 1) BETWEEN 'A' AND 'M';


-- 3

INSERT INTO flight
(id, 
 flight_number, 
 destination_country, 
 destination_city, 
 departure, 
 arrival, 
 passengers, 
 status, 
 delay, 
 is_national, 
 plane_id, 
 airport_id)
SELECT flight_id_seq.NEXTVAL, 
  '123', 
  airline.country, 
  airline.country, 
  (SELECT MAX(arrival)+1 FROM flight), 
  (SELECT MAX(arrival)+2 FROM flight),
  flight_passengers_seq.NEXTVAL, 
  'CONFIRMED', 
  0, 
  (CASE WHEN airline.country = airport.country THEN 1 ELSE 0 END),
  p.id, 
  airport.id
FROM plane p
  JOIN airline ON airline.id = p.airline_id
  JOIN flight f ON p.id = f.plane_id
  JOIN airport ON airport.id = f.airport_id
WHERE p.seat_count = (SELECT MAX(seat_count) FROM plane);


-- 4

UPDATE (SELECT f.arrival as OLD, 
               f.arrival + 0.2 * (f.arrival - f.departure) as NEW
        FROM flight f
          JOIN airport a ON a.id = f.airport_id
        WHERE f.destination_country = a.country 
              AND f.is_national = 0) t
SET t.OLD = t.NEW;


-- 5

DELETE (SELECT *
        FROM flight f
          INNER JOIN plane p ON p.id = f.plane_id
        WHERE f.passengers > p.seat_count);
