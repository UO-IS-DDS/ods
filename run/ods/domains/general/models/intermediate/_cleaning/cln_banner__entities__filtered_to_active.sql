
  
  create view "ods"."banner"."cln_banner__entities__filtered_to_active__dbt_tmp" as (
    select * from "ods"."banner"."int_banner__entities__filtered_to_active"
  );
