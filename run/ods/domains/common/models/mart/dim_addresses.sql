
  
    
    

    create  table
      "ods"."banner"."dim_addresses__dbt_tmp"
  
    as (
      with 

banner_addresses         as (select * from "ods"."banner"."int_banner__addresses__filtered_to_active"),

banner_address_types     as (select * from "ods"."banner"."int_banner__address_types"),

banner_address_states    as (select * from "ods"."banner"."int_banner__address_state_types"),

banner_address_nations   as (select * from "ods"."banner"."int_banner__address_nation_types"),

addresses_and_type_descs as (

  select 

  -- banner_addresses (driver)
  banner_addresses."internal_banner_id",
  banner_addresses."address_type_code",
  banner_addresses."address_seqno",
  banner_addresses."address_line_1",
  banner_addresses."address_line_2",
  banner_addresses."address_line_3",
  banner_addresses."city",
  banner_addresses."state_code",
  banner_addresses."zip_code",
  banner_addresses."nation_code",
  banner_addresses."updated_at",

   -- banner_address_types
  banner_address_types."address_type_desc",

   -- banner_address_states
  banner_address_states."state_desc",

   -- banner_address_nations
  banner_address_nations."nation_desc"

  from banner_addresses
  left join banner_address_types 
    on banner_address_types.address_type_code = 
           banner_addresses.address_type_code
  left join banner_address_states 
    on banner_address_states.state_code = 
           banner_addresses.state_code
  left join banner_address_nations 
    on banner_address_nations.nation_code = 
           banner_addresses.nation_code

)

select *,
       md5(cast(coalesce(cast(internal_banner_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(address_type_code as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(address_seqno as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT))           as ods_surrogate_key 
from addresses_and_type_descs
    );
  
  