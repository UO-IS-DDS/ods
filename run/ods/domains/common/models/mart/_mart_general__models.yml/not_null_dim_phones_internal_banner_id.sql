select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select internal_banner_id
from "ods"."banner"."dim_phones"
where internal_banner_id is null



      
    ) dbt_internal_test