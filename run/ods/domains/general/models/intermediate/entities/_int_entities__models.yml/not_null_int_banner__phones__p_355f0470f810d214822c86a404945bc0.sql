select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select internal_banner_id
from "ods"."banner"."int_banner__phones__pivoted_to__entities"
where internal_banner_id is null



      
    ) dbt_internal_test