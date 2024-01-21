
  
    
    

    create  table
      "ods"."banner"."mart_student_term_level__dbt_tmp"
  
    as (
      with banner_student_term_level as (

  select * from "ods"."banner"."int_banner__student_term_level"

),


final as (
    
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
  banner_student_term_level."major_1_desc",
  banner_student_term_level."major_2_desc",
  banner_student_term_level."major_3_desc",
  banner_student_term_level."major_4_desc",
  banner_student_term_level."minor_1_desc",
  banner_student_term_level."minor_2_desc",
  banner_student_term_level."minor_3_desc",
  banner_student_term_level."minor_4_desc"
 
  from banner_student_term_level

)

select *,
       md5(cast(coalesce(cast(internal_banner_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(term_code as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(level_code as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT))           as ods_surrogate_key 
from final
    );
  
  