SET TERMOUT OFF;

set serveroutput on;
variable a number;
variable b number;
variable c number;

CREATE SEQUENCE employee_id_seq START WITH 24001;
CREATE SEQUENCE flight_id_seq START WITH 30001;
CREATE SEQUENCE flight_passengers_seq START WITH 1 INCREMENT BY 30;
CREATE SEQUENCE plane_id_seq START WITH 12001;

alter system flush buffer_cache;
alter system flush shared_pool;

-- TRIGGERS
@/home/oracle/Desktop/scripts/triggers.sql

-- ZESTAW A
SAVEPOINT A;
exec :a := dbms_utility.get_time; 
@/home/oracle/Desktop/scripts/active-rules/sample_a.sql
exec :a := (dbms_utility.get_time - :a) / 100;
SPOOL /home/oracle/Desktop/scripts/active.txt;
exec dbms_output.put_line(:a);
SPOOL OFF;
ROLLBACK TO A;

alter system flush buffer_cache;
alter system flush shared_pool;

-- ZESTAW B
exec :b := dbms_utility.get_time;
@/home/oracle/Desktop/scripts/active-rules/sample_b.sql
exec :b := (dbms_utility.get_time - :b) / 100;
SPOOL /home/oracle/Desktop/scripts/active.txt APPEND;
exec dbms_output.put_line(:b);
SPOOL OFF;
ROLLBACK TO A;

alter system flush buffer_cache;
alter system flush shared_pool;

-- ZESTAW C
exec :c := dbms_utility.get_time;
@/home/oracle/Desktop/scripts/active-rules/sample_c.sql
exec :c := (dbms_utility.get_time - :c) / 100;
SPOOL /home/oracle/Desktop/scripts/active.txt APPEND;
exec dbms_output.put_line(:c);
SPOOL OFF;
ROLLBACK TO A;

DROP TRIGGER delete_employees;
BEGIN
	DBMS_SCHEDULER.DROP_JOB(job_name => 'add_flights');
END;
DROP TRIGGER insert_employees;
DROP TRIGGER update_flown_hours;
DROP TRIGGER add_flight_when;

DROP SEQUENCE employee_id_seq;
DROP SEQUENCE flight_id_seq;
DROP SEQUENCE flight_passengers_seq;
DROP SEQUENCE plane_id_seq;
