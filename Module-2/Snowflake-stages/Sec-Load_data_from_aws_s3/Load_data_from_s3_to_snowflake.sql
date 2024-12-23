/**************************************************************************/

/************** LOAD DATA FROM S3 TO SNOWFLAKE ******************/
create database demo_db;
Use database demo_db;

create or replace file format my_csv_format
type = csv;

-- Copy zip files

create or replace stage my_s3_stage
  --storage_integration = s3_int
  url = 's3://snowflakecrctest/emp/'
  file_format = my_csv_format;
--file_name string,
create or replace table demo_db.public.emp_ext_stage (
         --file_name string,
         first_name string ,
         last_name string ,
         email string ,
         streetaddress string ,
         city string ,
         start_date date
);


 

copy into demo_db.public.emp_ext_stage
from (select t.$1 , t.$2 , t.$3 , t.$4 , t.$5 , t.$6 from @my_s3_stage/ t)
pattern = '.*employees0[1-5].csv'
on_error = 'CONTINUE';

copy into demo_db.public.emp_ext_stage
from (select  metadata$filename,t.$1  , t.$2 , t.$3 , t.$4 , t.$5 , t.$6 from @my_s3_stage/ t )
--pattern = '.*employees0[1-5].csv'
on_error = 'CONTINUE';

copy into demo_db.public.emp_ext_stage
from (select case when t.$1='Ron' then 'Gone' else t.$1 end , t.$2 , t.$3 , t.$4 , t.$5 , t.$6 from @control_db.external_stages.my_s3_stage/ t )
--pattern = '.*employees0[1-5].csv'
on_error = 'CONTINUE';

TRUNCATE TABLE emp_ext_stage;

SELECT * FROM emp_ext_stage

select * from table(validate(emp_ext_stage, job_id=>'01a62908-3200-80f7-0001-4a360005d00a'));

