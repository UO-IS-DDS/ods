with banner__phones as (

  select * from "ods"."banner"."dim_phones"

),-- ^ Add more as requested
phones__pivoted_to_entity as (

  select

    internal_banner_id,
    max(case when phone_type_code = upper('ma') then phone_area end) as ma_phone_area,
      max(case when phone_type_code = upper('ma') then phone_number end) as ma_phone_number,
      max(case when phone_type_code = upper('ma') then phone_ext end) as ma_phone_ext,
      max(case when phone_type_code = upper('ma') then intl_access end) as ma_intl_access,
      max(case when phone_type_code = upper('ma') then phone_type_desc end) as ma_phone_type_desc,max(case when phone_type_code = upper('pr') then phone_area end) as pr_phone_area,
      max(case when phone_type_code = upper('pr') then phone_number end) as pr_phone_number,
      max(case when phone_type_code = upper('pr') then phone_ext end) as pr_phone_ext,
      max(case when phone_type_code = upper('pr') then intl_access end) as pr_intl_access,
      max(case when phone_type_code = upper('pr') then phone_type_desc end) as pr_phone_type_desc

  from banner__phones t1
  where updated_at = (
                      select max(t2.updated_at)
                      from banner__phones t2
                      where t2.internal_banner_id = t1.internal_banner_id
                        and t2.phone_type_code = t1.phone_type_code
                     )
  group by internal_banner_id

)

select *,
       md5(cast(coalesce(cast(internal_banner_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT))           as ods_surrogate_key 
from phones__pivoted_to_entity