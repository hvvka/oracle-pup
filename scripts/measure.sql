SET TERMOUT OFF;

set serveroutput on;
variable a number;
variable b number;
variable c number;

CREATE SEQUENCE employee_id_seq START WITH 8001;
CREATE SEQUENCE flight_id_seq START WITH 10001;
CREATE SEQUENCE flight_passengers_seq START WITH 1 INCREMENT BY 30;
CREATE SEQUENCE plane_id_seq START WITH 4001;

alter system flush buffer_cache;
alter system flush shared_pool;

-- ZESTAW A
SAVEPOINT A;
exec :a := dbms_utility.get_time;
@/home/oracle/Desktop/scripts/load-samples/sample_a.sql
exec :a := (dbms_utility.get_time - :a) / 100;
SPOOL /home/oracle/Desktop/scripts/out.txt;
exec dbms_output.put_line(:a);
SPOOL OFF;
ROLLBACK TO A;

alter system flush buffer_cache;
alter system flush shared_pool;

-- ZESTAW B
exec :b := dbms_utility.get_time;
@/home/oracle/Desktop/scripts/load-samples/sample_b.sql
exec :b := (dbms_utility.get_time - :b) / 100;
SPOOL /home/oracle/Desktop/scripts/out.txt APPEND;
exec dbms_output.put_line(:b);
SPOOL OFF;
ROLLBACK TO A;

alter system flush buffer_cache;
alter system flush shared_pool;

-- ZESTAW C
exec :c := dbms_utility.get_time;
@/home/oracle/Desktop/scripts/load-samples/sample_c.sql
exec :c := (dbms_utility.get_time - :c) / 100;
SPOOL /home/oracle/Desktop/scripts/out.txt APPEND;
exec dbms_output.put_line(:c);
SPOOL OFF;
ROLLBACK TO A;

DROP SEQUENCE employee_id_seq;
DROP SEQUENCE flight_id_seq;
DROP SEQUENCE flight_passengers_seq;
DROP SEQUENCE plane_id_seq;
