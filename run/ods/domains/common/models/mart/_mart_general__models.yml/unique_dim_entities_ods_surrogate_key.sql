select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    ods_surrogate_key as unique_field,
    count(*) as n_records

from "ods"."banner"."dim_entities"
where ods_surrogate_key is not null
group by ods_surrogate_key
having count(*) > 1



      
    ) dbt_internal_test