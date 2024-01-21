
    
    

with child as (
    select major_2_code as from_field
    from "ods"."banner"."mart_student_term_level"
    where major_2_code is not null
),

parent as (
    select major_code as to_field
    from "ods"."banner"."int_banner__majors"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


