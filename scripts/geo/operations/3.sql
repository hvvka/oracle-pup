SELECT a1.id, MIN(SDO_GEOM.SDO_DISTANCE(a1.location, a2.location, 0.005, 'unit=KM')) 
FROM airport_geo a1, airport_geo a2 WHERE a1.id != a2.id
GROUP BY a1.id;
