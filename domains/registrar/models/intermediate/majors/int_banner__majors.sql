with banner_major_types as (

    select * from {{ ref('stg_banner__saturn__stvmajr') }}

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
       {{ dbt_utils.generate_surrogate_key(
            ['major_code']) }}           as ods_surrogate_key
from test_clean 
