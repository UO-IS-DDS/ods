
  
    
    

    create  table
      "ods"."banner"."odsmgr_student__dbt_tmp"
  
    as (
      with 

fct_student_term_level as (select * from "ods"."banner"."fct_student_term_level"),

dim_person             as (select * from "ods"."banner"."dim_persons"),

final as (
    
  select 
    
    -- fct_student_term_level (driver)
    t1.internal_banner_id as person_uid,
    t1.term_code          as academic_period,
    t1.level_code         as student_level,
    case
         when t1.is_honors_college = 'N'
           then null
         else 'Y'
    end                   as honors_college_flag,
    t1.major_1_code       as packed_majors1,
    t1.major_2_code       as packed_majors2,
    t1.major_3_code       as packed_majors3,
    t1.major_4_code       as packed_majors4,
    t1.minor_1_code       as packed_minors1,
    t1.minor_2_code       as packed_minors2,
    t1.minor_3_code       as packed_minors3,
    t1.minor_4_code       as packed_minors4,

    -- dim_person
    t2.banner_id                             as "id", 
    replace(
            t2.last_name            || ', ' ||
            t2.preferred_first_name || ' '  ||
            t2.middle_initial       || '.',
            ' .',
            ''
           )                                 as "name"
 
  from fct_student_term_level t1
  left join dim_person t2
    on t2.internal_banner_id = 
       t1.internal_banner_id

)

select *,
       md5(cast(coalesce(cast(person_uid as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(academic_period as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(student_level as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT))           as ods_surrogate_key 
from final
    );
  
  