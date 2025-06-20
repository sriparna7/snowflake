{{
  config(
    materialized='incremental',
    unique_key='emp_id',
    incremental_strategy = 'merge',
    on_schema_change = 'sync_all_columns'
  )
}}

with source1 as
(select emp_id,concat(emp_id,'_',emp_name) as identity_main,emp_joining_dt
 from {{source('sri1','employee_data')}})
--from SNOW_DBT_ETL.ETL_CONNECT.EMPLOYEE_DATA)
select * from source1

{% if is_incremental() %}
WHERE emp_id > (SELECT MAX(emp_id) FROM {{ this }})
{% endif %}