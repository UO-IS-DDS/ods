select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select minor_code
from "ods"."banner"."dim_minors"
where minor_code is null



      
    ) dbt_internal_test