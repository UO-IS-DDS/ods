select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    email_type_desc as unique_field,
    count(*) as n_records

from "ods"."banner"."int_banner__email_address_types"
where email_type_desc is not null
group by email_type_desc
having count(*) > 1



      
    ) dbt_internal_test