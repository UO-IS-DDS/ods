
    
    

select
    nation_code as unique_field,
    count(*) as n_records

from "ods"."banner"."int_banner__address_nation_types"
where nation_code is not null
group by nation_code
having count(*) > 1


