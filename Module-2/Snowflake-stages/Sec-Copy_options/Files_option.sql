-- Create emp table.

 create or replace table emp (
         first_name string ,
         last_name string ,
         email string ,
         streetaddress string ,
         city string ,
         start_date date
);


create or replace file format csv_format
type = csv;

-- Create stage objete to read s3 file.
create or replace stage my_s3_stage
url = 's3://snowflakesmpdata/employee/'
file_format = csv_format;

-- Copy data using filter condition on file name.

copy into emp
from @my_s3_stage
file_format = (type = csv field_optionally_enclosed_by='"')
pattern = '.*employees0[1-5].csv'
-- ON_ERROR='CONTINUE'
files=('employees01.csv','employees02_errors.csv')

desc stage my_s3_stage;

-- Remove error files and load data

copy into emp
from @my_s3_stage
file_format = (type = csv field_optionally_enclosed_by='"')
pattern = '.*employees0[1-5].csv'
-- ON_ERROR='CONTINUE'
files=('employees01.csv','employees02_errors.csv')


-- files!= will not work. You need to use pattern option.

copy into emp
from @my_s3_stage
file_format = (type = csv field_optionally_enclosed_by='"')
pattern = '.*employees0[1-5].csv'
-- ON_ERROR='CONTINUE'
files!=('employees01.csv','employees02_errors.csv')


