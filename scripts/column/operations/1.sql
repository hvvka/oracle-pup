SELECT AVG(TRUNC((sysdate - e.birthdate) / 365)) AS "average employee age"
FROM employee_col e 
  JOIN flight_employee_col fe ON e.id = fe.employee_col_id
  JOIN flight_col f ON fe.flight_col_id = f.id
WHERE f.delay > 5.0 AND f.delay < 10.0;
