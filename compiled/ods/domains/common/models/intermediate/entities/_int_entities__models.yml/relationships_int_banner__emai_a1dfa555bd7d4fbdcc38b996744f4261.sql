
    
    

with child as (
    select internal_banner_id as from_field
    from "ods"."banner"."int_banner__email_addresses__pivoted_to__entities"
    where internal_banner_id is not null
),

parent as (
    select internal_banner_id as to_field
    from "ods"."banner"."int_banner__entities__filtered_to_active"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


