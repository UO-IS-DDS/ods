
    
    

with child as (
    select phone_type_code as from_field
    from "ods"."banner"."int_banner__phones__filtered_to_active"
    where phone_type_code is not null
),

parent as (
    select phone_type_code as to_field
    from "ods"."banner"."int_banner__phone_types"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


