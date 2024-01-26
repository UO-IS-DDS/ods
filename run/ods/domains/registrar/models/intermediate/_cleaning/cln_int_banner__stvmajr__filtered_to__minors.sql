
  
  create view "ods"."banner"."cln_int_banner__stvmajr__filtered_to__minors__dbt_tmp" as (
    select * from "ods"."banner"."dim_minors"
  );
