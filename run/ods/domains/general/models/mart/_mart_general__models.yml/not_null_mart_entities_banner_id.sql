select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select banner_id
from "ods"."banner"."mart_entities"
where banner_id is null



      
    ) dbt_internal_test