with banner_address_state_types as (

    select * from "ods"."banner"."stg_banner__saturn__stvstat"

),

-- unique_int_banner__address_state_types_state_desc
test_clean as (
  
  select *
  from banner_address_state_types t1
  -- failed test sql
  where t1.state_desc not in (
                               select t2.state_desc
                               from banner_address_state_types t2
                               group by t2.state_desc
                               having count(*) > 1
                             )
)

select *,
       md5(cast(coalesce(cast(state_code as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT))           as ods_surrogate_key
from test_clean