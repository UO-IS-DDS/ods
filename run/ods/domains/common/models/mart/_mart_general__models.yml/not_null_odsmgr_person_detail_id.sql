select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select id
from "ods"."banner"."odsmgr_person_detail"
where id is null



      
    ) dbt_internal_test