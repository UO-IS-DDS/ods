with banner__email_addresses as (

  select * from "ods"."banner"."dim_email_addresses"

),-- ^ Add more as requested
email_addresses__pivoted_to_entity as (

  select

    internal_banner_id,
    max(case when email_type_code = upper('uo') then email_address end) as uo_email_address,
      max(case when email_type_code = upper('uo') then email_type_desc end) as uo_email_type_desc

  from banner__email_addresses t1
  where updated_at = (
                      select max(t2.updated_at)
                      from banner__email_addresses t2
                      where t2.internal_banner_id = t1.internal_banner_id
                        and t2.email_type_code = t1.email_type_code
                     )
  group by internal_banner_id

)

select *,
       md5(cast(coalesce(cast(internal_banner_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT))           as ods_surrogate_key 
from email_addresses__pivoted_to_entity