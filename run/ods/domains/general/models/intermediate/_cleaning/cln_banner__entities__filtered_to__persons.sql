
  
  create view "ods"."banner"."cln_banner__entities__filtered_to__persons__dbt_tmp" as (
    select * from "ods"."banner"."int_banner__entities__filtered_to__persons"
  );
