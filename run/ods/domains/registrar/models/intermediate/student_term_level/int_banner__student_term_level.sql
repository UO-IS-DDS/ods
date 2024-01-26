
  
  create view "ods"."banner"."int_banner__student_term_level__dbt_tmp" as (
    with

banner_student_term_level as (select * from "ods"."banner"."stg_banner__saturn__sgbstdn"),

-- relationships_int_banner__student_term_level_internal_banner_id__internal_banner_id__ref_mart_persons
-- relationships_int_banner__student_term_level_major_%_code__major_code__ref_dim_majors
-- relationships_int_banner__student_term_level_minor_%_code__minor_code__ref_dim_minors
test_clean as (

  select *
  from banner_student_term_level t1
  where t1.internal_banner_id in (
                                   select t2.internal_banner_id
                                   from "ods"."banner"."cln_dim_persons" t2
                                 )
    and not exists (
                     (
                       select t1.major_1_code union
                       select t1.major_2_code union
                       select t1.major_3_code union
                       select t1.major_4_code
                     )

                     except

                     (
                       select major_code
                       from "ods"."banner"."cln_int_banner__stvmajr__filtered_to__majors"
                     )
                   )
   and not exists (
                     (
                       select t1.minor_1_code union
                       select t1.minor_2_code union
                       select t1.minor_3_code union
                       select t1.minor_4_code
                     )

                     except

                     (
                       select minor_code
                       from "ods"."banner"."cln_int_banner__stvmajr__filtered_to__minors"
                     )
                   )
)    

select *,
       md5(cast(coalesce(cast(internal_banner_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(term_code as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(level_code as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT))           as ods_surrogate_key 
from test_clean
  );
