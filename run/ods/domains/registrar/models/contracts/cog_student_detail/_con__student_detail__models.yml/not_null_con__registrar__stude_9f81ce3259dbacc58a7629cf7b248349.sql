select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select honors_college_flag
from "ods"."banner"."con__registrar__student_data_report"
where honors_college_flag is null



      
    ) dbt_internal_test