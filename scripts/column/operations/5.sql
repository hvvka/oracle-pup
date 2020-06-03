DELETE (SELECT *
        FROM employee_col e
          INNER JOIN airline_col a ON a.id = e.airline_col_id
        WHERE e.employment_date < a.establishment_date);
