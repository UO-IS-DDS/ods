select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select major_desc
from "ods"."banner"."dim_majors"
where major_desc is null



      
    ) dbt_internal_test