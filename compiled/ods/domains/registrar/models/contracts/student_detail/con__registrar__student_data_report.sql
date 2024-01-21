with student_term_level as (

  select * from "ods"."banner"."mart_student_term_level"

),

persons as (

   select * from "ods"."banner"."mart_persons"

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
       md5(cast(coalesce(cast(banner_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(term_code as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(level_code as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT))           as ods_surrogate_key
from con