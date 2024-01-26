select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select is_unlisted
from "ods"."banner"."dim_phones"
where is_unlisted is null



      
    ) dbt_internal_test