select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select student_level
from "ods"."banner"."odsmgr_student"
where student_level is null



      
    ) dbt_internal_test