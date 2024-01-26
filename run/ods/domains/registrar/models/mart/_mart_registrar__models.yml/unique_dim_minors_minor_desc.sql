select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    minor_desc as unique_field,
    count(*) as n_records

from "ods"."banner"."dim_minors"
where minor_desc is not null
group by minor_desc
having count(*) > 1



      
    ) dbt_internal_test