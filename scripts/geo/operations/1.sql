DELETE FROM flight_geo f
WHERE f.id IN (SELECT ff.id FROM flight_geo ff, airport_geo a
WHERE SDO_RELATE(a.area, ff.destination, 'mask=ANYINTERACT querytype=JOIN') = 'TRUE');
