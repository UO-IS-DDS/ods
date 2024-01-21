select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select is_confidential
from "ods"."banner"."mart_persons"
where is_confidential is null



      
    ) dbt_internal_test