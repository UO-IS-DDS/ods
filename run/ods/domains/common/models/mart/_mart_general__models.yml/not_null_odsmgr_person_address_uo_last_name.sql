select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select last_name
from "ods"."banner"."odsmgr_person_address_uo"
where last_name is null



      
    ) dbt_internal_test