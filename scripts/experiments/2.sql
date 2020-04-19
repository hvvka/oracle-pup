create table foo (bar varchar2(255));

create or replace trigger triggerA after insert on foo
begin 
    dbms_output.put_line('A');
end;
/

create or replace trigger triggerB after insert on foo
follows triggerA
begin
    dbms_output.put_line('B');
end;
/

create or replace trigger triggerC after insert on foo
follows triggerB
begin
    dbms_output.put_line('C');
end;
/

insert into foo values ('test');

drop trigger triggerC;
drop trigger triggerB;
drop trigger triggerA;

drop table foo;
