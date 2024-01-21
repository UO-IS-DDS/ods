with banner_person_details as (

  select * from "ods"."banner"."stg_banner__saturn__spbpers"

),

-- relationships_int_banner__person_details_internal_banner_id__internal_banner_id__ref_int_banner__entities__filtered_to__person
test_clean as (
     
  select *
  from banner_person_details t1
  -- failed test sql
  where t1.internal_banner_id in (
                                  select t2.internal_banner_id
                                  from "ods"."banner"."int_banner__entities__filtered_to__persons" t2
                                 )
)

select *,
       md5(cast(coalesce(cast(internal_banner_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT))           as ods_surrogate_key  
from test_clean