
  
  create view "ods"."banner"."int_banner__phones__filtered_to_active__dbt_tmp" as (
    with banner_phones as (

   select * from "ods"."banner"."stg_banner__saturn__sprtele"

),

banner_phone_types as (

   select * from "ods"."banner"."int_banner__phone_types"

),

phones_and_type_desc as (

  select 

  -- banner_phones (driver)
  banner_phones."internal_banner_id",
  banner_phones."phone_seqno",
  banner_phones."phone_type_code",
  banner_phones."updated_at",
  banner_phones."phone_area",
  banner_phones."phone_number",
  banner_phones."phone_ext",
  banner_phones."is_unlisted",
  banner_phones."phone_comment",
  banner_phones."intl_access",
  banner_phones."phone_country_code",

   -- banner_phone_types
  banner_phone_types."phone_type_desc"

  from banner_phones
  left join banner_phone_types 
    on banner_phone_types.phone_type_code = 
            banner_phones.phone_type_code
  where is_active = 'Y'

),

-- relationships_int_banner__phones__filtered_to_active_internal_banner_id__internal_banner_id__ref_int_banner__entities__filtered_to_active
test_clean as (

  select *
  from phones_and_type_desc t1
  -- failed test sql
  where t1.internal_banner_id in (
                                  select t2.internal_banner_id
                                  from "ods"."banner"."int_banner__entities__filtered_to_active" t2
                                 )
)

select *,
       md5(cast(coalesce(cast(internal_banner_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(phone_type_code as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(phone_seqno as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT))           as ods_surrogate_key 
from test_clean
  );
