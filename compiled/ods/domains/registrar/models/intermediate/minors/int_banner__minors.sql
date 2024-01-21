with banner_major_types as (

    select * from "ods"."banner"."stg_banner__saturn__stvmajr"

),

filter_to_minors as (
  
  select 
  
         banner_major_types."dept_code",
  banner_major_types."is_major",
  banner_major_types."is_minor",
         major_code                                                  as minor_code,
         major_desc                                                  as minor_desc

  from banner_major_types
  where is_minor = 'Y'
)

select *,
       md5(cast(coalesce(cast(minor_code as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT))           as ods_surrogate_key
from filter_to_minors