select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select academic_period
from "ods"."banner"."con__registrar__student_data_report"
where academic_period is null



      
    ) dbt_internal_test