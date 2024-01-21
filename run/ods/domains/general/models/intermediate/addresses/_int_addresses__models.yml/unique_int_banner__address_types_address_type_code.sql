select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    address_type_code as unique_field,
    count(*) as n_records

from "ods"."banner"."int_banner__address_types"
where address_type_code is not null
group by address_type_code
having count(*) > 1



      
    ) dbt_internal_test