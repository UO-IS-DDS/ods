
    
    

select
    state_desc as unique_field,
    count(*) as n_records

from "ods"."banner"."int_banner__address_state_types"
where state_desc is not null
group by state_desc
having count(*) > 1


