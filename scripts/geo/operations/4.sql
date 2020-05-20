BEGIN
FOR rec IN (SELECT a1.id a1id, a2.id a2id, SDO_GEOM.SDO_UNION(a1.area, a2.area, 0.005) newAirportArea
    FROM airport_geo a1, airport_geo a2
    WHERE ROUND(SDO_GEOM.SDO_AREA(SDO_GEOM.SDO_UNION(a1.area, a2.area, 0.005), 0.005)) < 30000
    AND SDO_RELATE(a1.area, a2.area,
     'mask=TOUCH querytype=WINDOW') = 'TRUE' AND a1.id != a2.id ORDER BY a1id ASC) 
LOOP
     UPDATE airport_geo
     SET area = rec.newAirportArea
     WHERE id = rec.a1id;
     
     DELETE FROM airport_geo
     WHERE id = rec.a2id;
     
END LOOP;
END;
