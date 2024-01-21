
    
    

select
    address_type_code as unique_field,
    count(*) as n_records

from "ods"."banner"."int_banner__address_types"
where address_type_code is not null
group by address_type_code
having count(*) > 1


