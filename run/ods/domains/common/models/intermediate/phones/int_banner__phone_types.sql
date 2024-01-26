
  
  create view "ods"."banner"."int_banner__phone_types__dbt_tmp" as (
    with banner_phone_types as (

    select * from "ods"."banner"."stg_banner__saturn__stvtele"

)

select *,
       md5(cast(coalesce(cast(phone_type_code as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT))           as ods_surrogate_key
from banner_phone_types
  );
