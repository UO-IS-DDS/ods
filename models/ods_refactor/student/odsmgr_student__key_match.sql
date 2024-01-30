{% set old_student %}
  select
    person_uid,
    academic_period,
    student_level
  from {{ source('odsmgr', 'student') }}
{% endset %}

{% set new_student %}
  select
    person_uid,
    academic_period,
    student_level
  from {{ ref('odsmgr_student') }}
{% endset %}

{{ audit_helper.compare_queries(
    a_query=old_student,
    b_query=new_student,
) }}