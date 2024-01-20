with student_term_level as (

  select * from {{ ref('mart_student_term_level') }}

),

persons as (

   select * from {{ ref('mart_persons') }}

),

con as (

  select persons.banner_id                      as banner_id,
         student_term_level.term_code           as term_code,
         student_term_level.level_code          as level_code,
         coalesce(persons.preferred_first_name,
                  persons.legal_first_name)     as first_name,
         persons.last_name                      as last_name
  from student_term_level 
  left join persons
    on persons.internal_banner_id = student_term_level.internal_banner_id
  where student_term_level.term_code = 201501
)

select *,
       {{ dbt_utils.generate_surrogate_key(
            ['banner_id',
             'term_code',
             'level_code']) }}           as ods_surrogate_key
from con