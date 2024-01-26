select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

with child as (
    select state_code as from_field
    from "ods"."banner"."int_banner__addresses__filtered_to_active"
    where state_code is not null
),

parent as (
    select state_code as to_field
    from "ods"."banner"."int_banner__address_state_types"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



      
    ) dbt_internal_test