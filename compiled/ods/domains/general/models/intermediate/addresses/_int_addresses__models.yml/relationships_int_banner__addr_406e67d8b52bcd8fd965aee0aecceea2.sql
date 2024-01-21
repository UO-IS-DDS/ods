
    
    

with child as (
    select address_type_code as from_field
    from "ods"."banner"."int_banner__addresses__filtered_to_active"
    where address_type_code is not null
),

parent as (
    select address_type_code as to_field
    from "ods"."banner"."int_banner__address_types"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


