
    
    

select
    address_type_desc as unique_field,
    count(*) as n_records

from "ods"."banner"."int_banner__address_types"
where address_type_desc is not null
group by address_type_desc
having count(*) > 1


