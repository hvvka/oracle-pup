create table foo (bar varchar2(255), baz timestamp);

create or replace trigger triggerA after insert on foo
begin 
    insert into foo values ('A', current_timestamp);
    dbms_output.put_line('A');
end;
/

create or replace trigger triggerB after insert on foo 
begin
    insert into foo values ('B', current_timestamp);
    dbms_output.put_line('B');
end;
/

create or replace trigger triggerC after insert on foo
begin
    insert into foo values ('C', current_timestamp);
    dbms_output.put_line('C');
end;
/

insert into foo values ('test', current_timestamp);

select * from foo;

drop trigger triggerC;
drop trigger triggerB;
drop trigger triggerA;

drop table foo;
