select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select is_person
from "ods"."banner"."dim_entities"
where is_person is null



      
    ) dbt_internal_test