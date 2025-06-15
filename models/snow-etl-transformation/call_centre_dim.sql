with cte as
(select cc_call_center_sk as sl_no,cc_call_center_id as id,cc_rec_start_date,
coalesce(cc_rec_end_date,'9999-01-01') as cc_rec_end_date,current_timestamp() as UPDATED_AT
 from {{source('sri1','call_centre')}})
select * from cte