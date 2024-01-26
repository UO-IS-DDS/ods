
  
  create view "ods"."banner"."int_banner__stvmajr__filtered_to__minors__dbt_tmp" as (
    with banner_minor_types as (

    select * from "ods"."banner"."stg_banner__saturn__stvmajr"

),

filter_to_minors as (
  
  select 
  
    banner_minor_types."dept_code",
    major_code                                                  as minor_code,
    major_desc                                                  as minor_desc

  from banner_minor_types
  where is_minor = 'Y'
)

select *,
       md5(cast(coalesce(cast(minor_code as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT))           as ods_surrogate_key
from filter_to_minors
  );
