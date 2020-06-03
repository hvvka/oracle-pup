SELECT a.company, SUM(TO_NUMBER(f.arrival - f.departure))
FROM airline_col a
  JOIN plane_col p ON a.id = p.airline_col_id
  JOIN flight_col f ON p.id = f.plane_col_id
WHERE f.departure = (SELECT MAX(departure) FROM flight_col)
GROUP BY a.company;
