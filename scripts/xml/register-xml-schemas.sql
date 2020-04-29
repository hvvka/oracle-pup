begin
DBMS_XMLSCHEMA.registerSchema('flightSchema.xsd',
'<xs:schema attributeFormDefault="unqualified" elementFormDefault="qualified" xmlns:xs="http://www.w3.org/2001/XMLSchema">
  <xs:element name="Flight">
    <xs:complexType>
      <xs:sequence>
        <xs:element type="xs:string" name="FlightNumber"/>
        <xs:element type="xs:string" name="DestinationCountry"/>
        <xs:element type="xs:string" name="DestinationCity"/>
        <xs:element type="xs:dateTime" name="Departure"/>
        <xs:element type="xs:dateTime" name="Arrival"/>
        <xs:element type="xs:integer" name="Passengers"/>
        <xs:element type="xs:string" name="Status"/>
        <xs:element type="xs:decimal" name="Delay"/>
        <xs:element type="xs:boolean" name="IsNational"/>
        <xs:element type="xs:integer" name="PlaneId"/>
        <xs:element type="xs:integer" name="AirportId"/>
      </xs:sequence>
      <xs:attribute type="xs:positiveInteger" name="id" use="required"/>
    </xs:complexType>
  </xs:element>
</xs:schema>'
);
end;
/

begin
DBMS_XMLSCHEMA.registerSchema('planeSchema.xsd',
'<xs:schema attributeFormDefault="unqualified" elementFormDefault="qualified" xmlns:xs="http://www.w3.org/2001/XMLSchema">
  <xs:element name="Plane">
    <xs:complexType>
      <xs:sequence>
        <xs:element type="xs:string" name="Manufacturer"/>
        <xs:element type="xs:string" name="Model"/>
		    <xs:element type="xs:date" name="ProductionDate"/>
        <xs:element type="xs:integer" name="SeatCount"/>
        <xs:element type="xs:decimal" name="FuelCapacity"/>
		    <xs:element type="xs:integer" name="CrusingRange"/>
		    <xs:element type="xs:integer" name="AirlineId"/>
      </xs:sequence>
      <xs:attribute type="xs:positiveInteger" name="id" use="required"/>
    </xs:complexType>
  </xs:element>
</xs:schema>'
);
end;
/

begin
DBMS_XMLSCHEMA.registerSchema('locationSchema.xsd',
'<xs:schema attributeFormDefault="unqualified" elementFormDefault="qualified" xmlns:xs="http://www.w3.org/2001/XMLSchema">
  <xs:element name="Location">
    <xs:complexType>
      <xs:sequence>
        <xs:element name="Coordinates">
          <xs:complexType>
            <xs:sequence>
              <xs:element type="xs:float" name="Longitude"/>
              <xs:element type="xs:float" name="Latitude"/>
            </xs:sequence>
          </xs:complexType>
        </xs:element>
		    <xs:element type="xs:string" name="Country"/>
        <xs:element type="xs:string" name="City"/>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
</xs:schema>'
);
end;
/
