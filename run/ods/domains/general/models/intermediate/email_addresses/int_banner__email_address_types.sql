
  
  create view "ods"."banner"."int_banner__email_address_types__dbt_tmp" as (
    with banner_email_address_types as (

    select * from "ods"."banner"."stg_banner__general__gtvemal"

)

select *,
       md5(cast(coalesce(cast(email_type_code as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT))           as ods_surrogate_key
from banner_email_address_types
  );
