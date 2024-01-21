with banner_major_types as (

    select * from "ods"."banner"."stg_banner__saturn__stvmajr"

),

filter_to_majors as (
  
  select *
  from banner_major_types
  where is_major = 'Y'
),

-- not_null_int_banner__majors_dept_code
test_clean as (

  select *
  from banner_major_types
  -- failed test sql
  where dept_code is not null

)

select *,
       md5(cast(coalesce(cast(major_code as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT))           as ods_surrogate_key
from test_clean