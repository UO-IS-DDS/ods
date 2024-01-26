select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select dept_code
from "ods"."banner"."dim_majors"
where dept_code is null



      
    ) dbt_internal_test