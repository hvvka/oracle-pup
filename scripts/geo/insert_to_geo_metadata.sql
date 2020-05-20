INSERT INTO user_sdo_geom_metadata
   (TABLE_NAME,
    COLUMN_NAME,
    DIMINFO,
    SRID)
 VALUES (
 'flight_geo',
 'route',
 SDO_DIM_ARRAY(   -- 100X100 grid
   SDO_DIM_ELEMENT('X', 0, 100, 0.005),
   SDO_DIM_ELEMENT('Y', 0, 100, 0.005)
    ),
 NULL   -- SRID
);

INSERT INTO user_sdo_geom_metadata
    (TABLE_NAME,
     COLUMN_NAME,
     DIMINFO,
     SRID)
  VALUES (
  'flight_geo',
  'destination',
  SDO_DIM_ARRAY(   -- 100X100 grid
    SDO_DIM_ELEMENT('X', 0, 100, 0.005),
    SDO_DIM_ELEMENT('Y', 0, 100, 0.005)
     ),
  NULL   -- SRID
);

INSERT INTO user_sdo_geom_metadata
    (TABLE_NAME,
     COLUMN_NAME,
     DIMINFO,
     SRID)
  VALUES (
  'airport_geo',
  'area',
  SDO_DIM_ARRAY(   -- 100X100 grid
    SDO_DIM_ELEMENT('X', 0, 100, 0.005),
    SDO_DIM_ELEMENT('Y', 0, 100, 0.005)
     ),
  NULL   -- SRID
);
