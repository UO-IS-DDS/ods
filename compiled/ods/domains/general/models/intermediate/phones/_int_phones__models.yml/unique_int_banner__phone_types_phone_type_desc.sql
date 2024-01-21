
    
    

select
    phone_type_desc as unique_field,
    count(*) as n_records

from "ods"."banner"."int_banner__phone_types"
where phone_type_desc is not null
group by phone_type_desc
having count(*) > 1

