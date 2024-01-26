select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select student_level
from "ods"."banner"."con__registrar__student_data_report"
where student_level is null



      
    ) dbt_internal_test