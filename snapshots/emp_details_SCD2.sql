{% snapshot emp_details_SCD2 %}
    {{
        config(
            unique_key="emp_id",
            strategy="check",
            check_cols=["emp_id", "dept", "emp_joining_dt"],
            invalidate_hard_deletes=True,
        )
    }}

    select c.emp_id, d.dept, c.emp_joining_dt

    from snow_dbt_etl.etl_connect.emp_dept d
    join {{ ref("employee_SCD") }} c on c.emp_id = d.emp_id

{% endsnapshot %}
