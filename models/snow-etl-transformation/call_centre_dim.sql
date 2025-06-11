with cte as
(select cc_call_center_sk as sl_no,cc_call_center_id as id,cc_rec_start_date,
coalesce(cc_rec_end_date,'9999-01-01') as cc_rec_end_date from SNOW_DBT_ETL.ETL_CONNECT.CALL_CENTRE )
select * from cte