select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select is_honors_college
from "ods"."banner"."int_banner__student_term_level"
where is_honors_college is null



      
    ) dbt_internal_test