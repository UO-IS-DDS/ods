with banner_student_term_level as (

   select * from "ods"."banner"."stg_banner__saturn__sgbstdn"

),

banner_majors as (

   select * from "ods"."banner"."int_banner__majors"

),

banner_minors as (

   select * from "ods"."banner"."int_banner__minors"

),

banner_student_term_level_with_desc as (

  select 

    -- banner_student_term_level (driver)
    banner_student_term_level."internal_banner_id",
  banner_student_term_level."term_code",
  banner_student_term_level."level_code",
  banner_student_term_level."admit_term",
  banner_student_term_level."honors_college_ind",
  banner_student_term_level."major_1_code",
  banner_student_term_level."major_2_code",
  banner_student_term_level."major_3_code",
  banner_student_term_level."major_4_code",
  banner_student_term_level."minor_1_code",
  banner_student_term_level."minor_2_code",
  banner_student_term_level."minor_3_code",
  banner_student_term_level."minor_4_code",
    maj1.major_desc                                                   as major_1_desc,
    maj2.major_desc                                                   as major_2_desc,
    maj3.major_desc                                                   as major_3_desc,
    maj4.major_desc                                                   as major_4_desc,
    min1.minor_desc                                                   as minor_1_desc,
    min2.minor_desc                                                   as minor_2_desc,
    min3.minor_desc                                                   as minor_3_desc,
    min4.minor_desc                                                   as minor_4_desc,

  from banner_student_term_level
  left join banner_majors maj1 on maj1.major_code = banner_student_term_level.major_1_code
  left join banner_majors maj2 on maj2.major_code = banner_student_term_level.major_2_code
  left join banner_majors maj3 on maj3.major_code = banner_student_term_level.major_3_code
  left join banner_majors maj4 on maj4.major_code = banner_student_term_level.major_4_code
  left join banner_minors min1 on min1.minor_code = banner_student_term_level.minor_1_code
  left join banner_minors min2 on min2.minor_code = banner_student_term_level.minor_2_code
  left join banner_minors min3 on min3.minor_code = banner_student_term_level.minor_3_code
  left join banner_minors min4 on min4.minor_code = banner_student_term_level.minor_4_code

),

-- relationships_int_banner__student_term_level_internal_banner_id__internal_banner_id__ref_mart_persons
test_clean as (

  select *
  from banner_student_term_level_with_desc t1
  where t1.internal_banner_id in (
                                   select t2.internal_banner_id
                                   from "ods"."banner"."mart_persons" t2
                                 )
)

select *,
       md5(cast(coalesce(cast(internal_banner_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(term_code as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(level_code as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT))           as ods_surrogate_key 
from test_clean