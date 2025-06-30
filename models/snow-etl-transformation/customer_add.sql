select a.id, a.cc_rec_start_date, b.ca_street_number, b.ca_street_name
from {{ ref("call_centre_dim") }} a
join
    {{ var("table_name") }} b
    on a.id = {{ var("column_name") }}
