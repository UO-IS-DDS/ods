select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select banner_id
from "ods"."banner"."int_banner__entities__filtered_to__persons"
where banner_id is null



      
    ) dbt_internal_test