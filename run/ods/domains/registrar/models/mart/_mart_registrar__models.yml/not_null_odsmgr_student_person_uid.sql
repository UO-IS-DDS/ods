select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select person_uid
from "ods"."banner"."odsmgr_student"
where person_uid is null



      
    ) dbt_internal_test