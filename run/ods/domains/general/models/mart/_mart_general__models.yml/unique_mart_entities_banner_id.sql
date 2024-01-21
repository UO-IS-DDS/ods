select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    banner_id as unique_field,
    count(*) as n_records

from "ods"."banner"."mart_entities"
where banner_id is not null
group by banner_id
having count(*) > 1



      
    ) dbt_internal_test