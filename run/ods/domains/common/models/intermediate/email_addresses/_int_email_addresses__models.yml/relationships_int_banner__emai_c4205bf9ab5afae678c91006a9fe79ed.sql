select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

with child as (
    select email_type_code as from_field
    from "ods"."banner"."int_banner__email_addresses__filtered_to_active"
    where email_type_code is not null
),

parent as (
    select email_type_code as to_field
    from "ods"."banner"."int_banner__email_address_types"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



      
    ) dbt_internal_test