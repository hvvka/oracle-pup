SELECT COUNT(*)
FROM airport_geo a1, airport_geo a2
WHERE a1.id != a2.id
AND SDO_RELATE(a1.area, a2.area, 'mask=OVERLAPBDYINTERSECT querytype=JOIN') = 'TRUE';
