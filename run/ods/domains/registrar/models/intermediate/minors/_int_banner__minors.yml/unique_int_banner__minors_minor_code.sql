select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    minor_code as unique_field,
    count(*) as n_records

from "ods"."banner"."int_banner__minors"
where minor_code is not null
group by minor_code
having count(*) > 1



      
    ) dbt_internal_test