
  
    
    

    create  table
      "ods"."banner"."dim_majors__dbt_tmp"
  
    as (
      select * from "ods"."banner"."int_banner__stvmajr__filtered_to__majors"
    );
  
  