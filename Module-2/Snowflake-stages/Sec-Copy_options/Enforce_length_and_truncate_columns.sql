ENFORCE_LENGTH = TRUE | FALSE
TRUNCATECOLUMNS = TRUE | FALSE

create or replace file format csv_format
type = csv;

-- Create stage objete to read s3 file.
create or replace stage my_s3_stage
url = 's3://snowflakesmpdata/employee/'
file_format = csv_format;

desc stage my_s3_stage

select * from emp

truncate table emp;


copy into emp
from @my_s3_stage
file_format = (type = csv field_optionally_enclosed_by='"')
--pattern = '.*employees0[1-5].csv'
ON_ERROR='CONTINUE'
--TRUNCATECOLUMNS = TRUE
ENFORCE_LENGTH = FALSE