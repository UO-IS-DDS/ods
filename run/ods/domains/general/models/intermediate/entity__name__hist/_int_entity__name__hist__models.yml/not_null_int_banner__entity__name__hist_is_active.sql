select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select is_active
from "ods"."banner"."int_banner__entity__name__hist"
where is_active is null



      
    ) dbt_internal_test