SET TERMOUT OFF;

set serveroutput on;
variable a number;
variable b number;
variable c number;
variable d number;
variable e number;

CREATE SEQUENCE employee_id_seq START WITH 24001;
CREATE SEQUENCE flight_id_seq START WITH 30001;
CREATE SEQUENCE flight_passengers_seq START WITH 1 INCREMENT BY 30;
CREATE SEQUENCE plane_id_seq START WITH 12001;

alter system flush buffer_cache;
alter system flush shared_pool;

-- ZESTAW A
SAVEPOINT A;
exec :a := dbms_utility.get_time;
@/home/oracle/Desktop/scripts/col/1.sql
exec :a := (dbms_utility.get_time - :a) / 100;
SPOOL /home/oracle/Desktop/scripts/col.txt;
exec dbms_output.put_line(:a);
SPOOL OFF;
ROLLBACK TO A;

alter system flush buffer_cache;
alter system flush shared_pool;

-- ZESTAW B
exec :b := dbms_utility.get_time;
@/home/oracle/Desktop/scripts/col/2.sql
exec :b := (dbms_utility.get_time - :b) / 100;
SPOOL /home/oracle/Desktop/scripts/col.txt APPEND;
exec dbms_output.put_line(:b);
SPOOL OFF;
ROLLBACK TO A;

alter system flush buffer_cache;
alter system flush shared_pool;

-- ZESTAW C
exec :c := dbms_utility.get_time;
@/home/oracle/Desktop/scripts/col/3.sql
exec :c := (dbms_utility.get_time - :c) / 100;
SPOOL /home/oracle/Desktop/scripts/col.txt APPEND;
exec dbms_output.put_line(:c);
SPOOL OFF;
ROLLBACK TO A;

alter system flush buffer_cache;
alter system flush shared_pool;

-- ZESTAW D
exec :d := dbms_utility.get_time;
@/home/oracle/Desktop/scripts/col/4.sql
exec :d := (dbms_utility.get_time - :d) / 100;
SPOOL /home/oracle/Desktop/scripts/col.txt APPEND;
exec dbms_output.put_line(:d);
SPOOL OFF;
ROLLBACK TO A;

alter system flush buffer_cache;
alter system flush shared_pool;

-- ZESTAW E
exec :e := dbms_utility.get_time;
@/home/oracle/Desktop/scripts/col/5.sql
exec :e := (dbms_utility.get_time - :e) / 100;
SPOOL /home/oracle/Desktop/scripts/col.txt APPEND;
exec dbms_output.put_line(:e);
SPOOL OFF;
ROLLBACK TO A;

DROP SEQUENCE employee_id_seq;
DROP SEQUENCE flight_id_seq;
DROP SEQUENCE flight_passengers_seq;
DROP SEQUENCE plane_id_seq;
