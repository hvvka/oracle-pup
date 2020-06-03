INSERT INTO plane_col (id, 
                       manufacturer, 
                       model, 
                       production_date, 
                       seat_count, 
                       fuel_capacity, 
                       cruising_range, 
                       airline_col_id)
SELECT plane_id_seq.NEXTVAL, a, b, c, d, e, f, g
FROM (SELECT p.manufacturer a, 
             p.model b, 
             p.production_date c, 
             p.seat_count d, 
             p.fuel_capacity e, 
             p.cruising_range f, 
             p.airline_col_id g 
      FROM plane_col p
      ORDER BY TRUNC(p.fuel_capacity) / p.cruising_range);
