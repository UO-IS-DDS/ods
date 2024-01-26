select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

with child as (
    select person_uid as from_field
    from "ods"."banner"."odsmgr_student"
    where person_uid is not null
),

parent as (
    select internal_banner_id as to_field
    from "ods"."banner"."dim_persons"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



      
    ) dbt_internal_test