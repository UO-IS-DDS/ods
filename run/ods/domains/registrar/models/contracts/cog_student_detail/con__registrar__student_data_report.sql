
  
    
    

    create  table
      "ods"."banner"."con__registrar__student_data_report__dbt_tmp"
  
    as (
      with 

student          as (select * from "ods"."banner"."odsmgr_student"),

person_detail    as (select * from "ods"."banner"."odsmgr_person_detail"),

person_addres_uo as (select * from "ods"."banner"."odsmgr_person_address_uo"),

con as (

  select 
  
    -- student (driver)
    student.person_uid,
    student.academic_period,
    student.student_level,
    student.honors_college_flag,
    student.packed_majors1,
    student.packed_majors2,
    student.packed_majors3,
    student.packed_majors4,
    student.packed_minors1,
    student.packed_minors2,
    student.packed_minors3,
    student.packed_minors4,

    -- person_address_uo
    person_addres_uo.mapr_street_line1,
    person_addres_uo.mapr_street_line2,
    person_addres_uo.mapr_street_line3,

    -- person_detail
    confidentiality_ind

  from student 
  left join person_detail
    on person_detail.person_uid = 
             student.person_uid
  left join person_addres_uo
    on person_addres_uo.person_uid = 
                student.person_uid
  -- limit dataset for speed!
  where student.academic_period > 201507
)

select *,
       md5(cast(coalesce(cast(person_uid as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(academic_period as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(student_level as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT))           as ods_surrogate_key
from con
    );
  
  