# A1
SELECT SUM(CASE WHEN extractValue(value(f), '//Delay') > 0 THEN 1 ELSE 0 END) / COUNT(*)
FROM Flight_xml f
	JOIN Plane_xml p ON extractValue(value(p), '//@id') = extractValue(value(f), '//PlaneId')
	JOIN airline a ON a.id = extractValue(value(p), '//AirlineId')
	INNER JOIN flight_employee fe ON extractValue(value(f), '//@id') = fe.flight_id
  INNER JOIN employee e ON e.id = fe.employee_id
GROUP BY a.id;


# B1
SELECT COUNT(*)
FROM Flight_xml f
	JOIN Airport_xml a ON a.id = extractValue(value(f), '//AirportId')
WHERE EXTRACT(MONTH FROM TRUNC(extractValue(value(f), '//Departure'))) IN (1, 6)
		  AND extractValue(a.location, '//Coordinates/Longitude') BETWEEN -73.98283055555555 AND -34.79314722222222;


# B2
SELECT DISTINCT extractValue(value(p), '//Model')
FROM Plane_xml p
	JOIN airline a ON a.id = extractValue(value(p), '//AirlineId')
	JOIN employee e ON a.id = e.airline_id
WHERE SUBSTR(e.name, 1, 1) BETWEEN 'A' AND 'M';


# A4
UPDATE employee eu
SET eu.flown_hours = (SELECT SUM(24 * (sysdate + extractValue(value(f), '//Arrival') - extractValue(value(f), '//Departure') - sysdate)
											FROM Flight_xml f
											JOIN flight_employee fe ON extractValue(value(f), '//@id') = fe.flight_id
											JOIN employee e ON e.id = fe.employee_id);


# B5
DELETE (SELECT *
        FROM Flight_xml, XMLTable('for $f in /Flight return $f' passing object_value) xf
	        INNER JOIN Plane_xml p ON extractValue(value(p), '//@id') = extractValue(value(xf), '//PlaneId')
        WHERE extractValue(value(xf), '//Passengers') > extractValue(value(p
), '//SeatCount');
