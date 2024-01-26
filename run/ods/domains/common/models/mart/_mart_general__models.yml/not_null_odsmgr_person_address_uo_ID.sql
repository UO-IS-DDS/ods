select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select ID
from "ods"."banner"."odsmgr_person_address_uo"
where ID is null



      
    ) dbt_internal_test