
    
    

select
    minor_desc as unique_field,
    count(*) as n_records

from "ods"."banner"."dim_minors"
where minor_desc is not null
group by minor_desc
having count(*) > 1


