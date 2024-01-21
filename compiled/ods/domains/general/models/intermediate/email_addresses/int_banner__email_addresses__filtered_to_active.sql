with banner_email_addresses as (

   select * from "ods"."banner"."stg_banner__general__goremal"

),

banner_email_address_types as (

   select * from "ods"."banner"."int_banner__email_address_types"

),

emails_and_type_desc as (

  select 

  -- banner_email_addresses (driver)
  banner_email_addresses."internal_banner_id",
  banner_email_addresses."email_type_code",
  banner_email_addresses."email_address",
  banner_email_addresses."updated_at",

   -- banner_email_address_types
  banner_email_address_types."email_type_desc"

  from banner_email_addresses
  left join banner_email_address_types 
    on banner_email_address_types.email_type_code = 
           banner_email_addresses.email_type_code
  where is_active = 'Y'

),

-- relationships_int_banner__email_addresses__filtered_to_active_internal_banner_id__internal_banner_id__ref_int_banner__entities__filtered_to_active
test_clean as (

  select *
  from emails_and_type_desc t1
  -- failed test sql
  where t1.internal_banner_id in (
                                  select t2.internal_banner_id
                                  from "ods"."banner"."int_banner__entities__filtered_to_active" t2
                                 )

)

select *,
       md5(cast(coalesce(cast(internal_banner_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(email_type_code as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(email_address as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT))           as ods_surrogate_key 
from test_clean