import fileinput
from random import uniform

AIRPORT_FILE = "airport_geo.sql"
FLIGHT_FILE = "flight_geo.sql"


def convert_airport(filename):
    with fileinput.input(filename, inplace=True) as f:
        for line in f:
            x = float(line.split("'")[-8])
            y = float(line.split("'")[-6])
            line = line.replace("'{}','{}'".format(x, y),
                                "MDSYS.SDO_GEOMETRY(2001,8307,MDSYS.SDO_POINT_TYPE({},{},NULL),NULL,NULL)".format(x, y))
            line = line.replace(");",
                                ",MDSYS.SDO_GEOMETRY(2003,8307,NULL,MDSYS.SDO_ELEM_INFO_ARRAY(1,1003,4),"
                                "MDSYS.SDO_ORDINATE_ARRAY({},{}, {},{}, {},{})));".format(
                                    x - 1, y - 2, x + 1, y, x - 1, y + 2))
            print(line, end='')


def new_point():
    return uniform(-180, 180), uniform(-90, 90)


def convert_flight(filename):
    with fileinput.input(filename, inplace=True) as f:
        for line in f:
            to_be_appended = line.split(",'")[1]

            x, y = new_point()
            from_x, from_y = new_point()
            destination = ",MDSYS.SDO_GEOMETRY(2001,8307,MDSYS.SDO_POINT_TYPE({}, {}, NULL),NULL,NULL)".format(x, y)
            route = ",MDSYS.SDO_GEOMETRY(2002,NULL,NULL,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,1),MDSYS.SDO_ORDINATE_ARRAY(" \
                    "{},{}, {},{}))".format(from_x, from_y, x, y)

            print(line.replace(to_be_appended, to_be_appended + destination + route), end='')


convert_airport(AIRPORT_FILE)
convert_flight(FLIGHT_FILE)
