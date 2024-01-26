select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select academic_period
from "ods"."banner"."odsmgr_student"
where academic_period is null



      
    ) dbt_internal_test