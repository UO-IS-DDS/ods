select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    internal_banner_id as unique_field,
    count(*) as n_records

from "ods"."banner"."int_banner__email_addresses__pivoted_to__entities"
where internal_banner_id is not null
group by internal_banner_id
having count(*) > 1



      
    ) dbt_internal_test