UPDATE airline_col
SET establishment_date = (SELECT MIN(f.departure)
                          FROM flight_col f
                          JOIN plane_col p ON p.id = f.plane_col_id
                          JOIN airline_col a ON a.id = p.airline_col_id);
