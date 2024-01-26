select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select confidentiality_ind
from "ods"."banner"."odsmgr_person_detail"
where confidentiality_ind is null



      
    ) dbt_internal_test