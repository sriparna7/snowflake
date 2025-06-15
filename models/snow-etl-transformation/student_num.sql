select name, sum(score) as tot_score
from {{ source("sri1", "student_assignment") }}
{% if var("student_name") == "A" or var("student_name") == "B" %}
    where name in ('A', 'B')
{% else %} where name = 'C'
{% endif %}
group by name
