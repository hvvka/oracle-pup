SELECT e.id
FROM user_sdo_geom_metadata m, employee e
INNER JOIN flight_employee fe ON e.id = fe.employee_id
INNER JOIN flight_geo f ON f.id = fe.flight_id
WHERE SDO_GEOM.SDO_LENGTH(f.route, m.diminfo) =
(SELECT MAX(SDO_GEOM.SDO_LENGTH(ff.route, mm.diminfo)) FROM flight_geo ff, user_sdo_geom_metadata mm);
