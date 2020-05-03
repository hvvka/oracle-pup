-- ZESTAW B


-- 1 

SELECT COUNT(*)
FROM Flight_xml f
  JOIN Airport_xml a ON a.id = extractValue(value(f), '//AirportId')
WHERE EXTRACT(MONTH FROM TRUNC(extractValue(value(f), '//Departure'))) IN (1, 6)
      AND extractValue(a.location, '//Coordinates/Longitude') BETWEEN -73.98283055555555 AND -34.79314722222222;


-- 2

SELECT DISTINCT extractValue(value(p), '//Model')
FROM Plane_xml p
  JOIN airline a ON a.id = extractValue(value(p), '//AirlineId')
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
        FROM Flight_xml, XMLTable('for $f in /Flight return $f' passing object_value) xf
          INNER JOIN Plane_xml p ON extractValue(value(p), '//@id') = extractValue(value(xf), '//PlaneId')
        WHERE extractValue(value(xf), '//Passengers') > extractValue(value(p
), '//SeatCount');

