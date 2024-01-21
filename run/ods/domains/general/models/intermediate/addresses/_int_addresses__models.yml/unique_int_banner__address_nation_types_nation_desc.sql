select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    nation_desc as unique_field,
    count(*) as n_records

from "ods"."banner"."int_banner__address_nation_types"
where nation_desc is not null
group by nation_desc
having count(*) > 1



      
    ) dbt_internal_test