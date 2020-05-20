CREATE INDEX Route_Index ON flight_geo(route) INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2;
CREATE INDEX Destination_Index ON flight_geo(destination) INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2;
CREATE INDEX Area_Index ON airport_geo(area) INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2;