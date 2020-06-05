SAVEPOINT A;


-- 4 different compression methods
ALTER TABLE PLANE_COL INMEMORY MEMCOMPRESS FOR QUERY LOW;
ALTER TABLE PLANE_COL INMEMORY MEMCOMPRESS FOR QUERY HIGH;
ALTER TABLE PLANE_COL INMEMORY MEMCOMPRESS FOR CAPACITY LOW;
ALTER TABLE PLANE_COL INMEMORY MEMCOMPRESS FOR CAPACITY HIGH;
-- read compression method
SELECT inmemory, inmemory_compression FROM user_tables WHERE table_name='PLANE_COL';


-- operation 3
INSERT INTO plane_col (id, manufacturer, model, production_date, seat_count, fuel_capacity, cruising_range, airline_col_id) SELECT plane_id_seq.NEXTVAL, a, b, c, d, e, f, g FROM (SELECT p.manufacturer a, p.model b, p.production_date c, p.seat_count d, p.fuel_capacity e, p.cruising_range f, p.airline_col_id g FROM plane_col p ORDER BY TRUNC(p.fuel_capacity) / p.cruising_range);


-- reclaim wasted space
-- Enable row movement
ALTER TABLE plane_col ENABLE ROW MOVEMENT;
-- Recover space and amend the high water mark (HWM)
ALTER TABLE plane_col SHRINK SPACE;
-- Recover space, but don't amend the HWM
ALTER TABLE plane_col SHRINK SPACE COMPACT;
-- Recover space for the object and all dependant objects
ALTER TABLE plane_col SHRINK SPACE CASCADE;


-- read table size
select bytes, blocks, extents from user_segments where segment_type='TABLE' and segment_name='PLANE_COL';
select b.tablespace_name, tbs_size SizeMb, a.free_space FreeMb from  (select tablespace_name, round(sum(bytes)/1024/1024 ,2) as free_space from dba_free_space group by tablespace_name) a, (select tablespace_name, sum(bytes)/1024/1024 as tbs_size from dba_data_files group by tablespace_name) b where a.tablespace_name=b.tablespace_name;


ROLLBACK TO A;
alter system flush buffer_cache;
alter system flush shared_pool;

