
    
    

with child as (
    select internal_banner_id as from_field
    from "ods"."banner"."mart_student_term_level"
    where internal_banner_id is not null
),

parent as (
    select internal_banner_id as to_field
    from "ods"."banner"."mart_persons"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


