
    
    

select
    email_type_code as unique_field,
    count(*) as n_records

from "ods"."banner"."int_banner__email_address_types"
where email_type_code is not null
group by email_type_code
having count(*) > 1

