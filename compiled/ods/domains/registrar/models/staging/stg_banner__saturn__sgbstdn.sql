with source as (

    select * from "ods"."banner"."sgbstdn"

),

renamed as (

    select
        sgbstdn_pidm                                                                    as internal_banner_id,
        sgbstdn_term_code_eff                                                           as term_code,
        sgbstdn_levl_code                                                               as level_code,
        sgbstdn_term_code_admit                                                         as admit_term,
        case when 'HC' in (sgbstdn_majr_code_minr_2_2, 
                           sgbstdn_majr_code_minr_2,
                           sgbstdn_majr_code_minr_1_2, 
                           sgbstdn_majr_code_minr_1) 
               then 'Y' 
            else 'N'
        end                                                                             as honors_college_ind,
        (select column_name 
         from (select column_name, row_number() over (order by column_name) rn
               from (select sgbstdn_majr_code_1   as column_name union
                     select sgbstdn_majr_code_1_2 as column_name union
                     select sgbstdn_majr_code_2   as column_name union
                     select sgbstdn_majr_code_2_2 as column_name) t) where rn = 1)      as major_1_code,
        (select column_name 
         from (select column_name, row_number() over (order by column_name) rn
               from (select sgbstdn_majr_code_1   as column_name union
                     select sgbstdn_majr_code_1_2 as column_name union
                     select sgbstdn_majr_code_2   as column_name union
                     select sgbstdn_majr_code_2_2 as column_name) t) where rn = 1)      as major_2_code,
        (select column_name 
         from (select column_name, row_number() over (order by column_name) rn
               from (select sgbstdn_majr_code_1   as column_name union
                     select sgbstdn_majr_code_1_2 as column_name union
                     select sgbstdn_majr_code_2   as column_name union
                     select sgbstdn_majr_code_2_2 as column_name) t) where rn = 1)      as major_3_code,
        (select column_name 
         from (select column_name, row_number() over (order by column_name) rn
               from (select sgbstdn_majr_code_1   as column_name union
                     select sgbstdn_majr_code_1_2 as column_name union
                     select sgbstdn_majr_code_2   as column_name union
                     select sgbstdn_majr_code_2_2 as column_name) t) where rn = 1)      as major_4_code,
        (select column_name 
        from (select column_name, row_number() over (order by column_name) rn
              from (select sgbstdn_majr_code_minr_1   as column_name union
                    select sgbstdn_majr_code_minr_1_2 as column_name union
                    select sgbstdn_majr_code_minr_2   as column_name union
                    select sgbstdn_majr_code_minr_2_2 as column_name) t) where rn = 1)  as minor_1_code,                      
       (select column_name 
        from (select column_name, row_number() over (order by column_name) rn
              from (select sgbstdn_majr_code_minr_1   as column_name union
                    select sgbstdn_majr_code_minr_1_2 as column_name union
                    select sgbstdn_majr_code_minr_2   as column_name union
                    select sgbstdn_majr_code_minr_2_2 as column_name) t) where rn = 2)  as minor_2_code,
       (select column_name 
        from (select column_name, row_number() over (order by column_name) rn
              from (select sgbstdn_majr_code_minr_1   as column_name union
                    select sgbstdn_majr_code_minr_1_2 as column_name union
                    select sgbstdn_majr_code_minr_2   as column_name union
                    select sgbstdn_majr_code_minr_2_2 as column_name) t) where rn = 3)  as minor_3_code,
       (select column_name 
        from (select column_name, row_number() over (order by column_name) rn
              from (select sgbstdn_majr_code_minr_1   as column_name union
                    select sgbstdn_majr_code_minr_1_2 as column_name union
                    select sgbstdn_majr_code_minr_2   as column_name union
                    select sgbstdn_majr_code_minr_2_2 as column_name) t) where rn = 4)  as minor_4_code
                    

    from source

)

select * from renamed

-- Unused Fields --
        /*
        sgbstdn_stst_code,
        sgbstdn_styp_code,
        sgbstdn_term_code_matric,
        sgbstdn_exp_grad_date,
        sgbstdn_camp_code,
        sgbstdn_full_part_ind,
        sgbstdn_sess_code,
        sgbstdn_resd_code,
        sgbstdn_coll_code_1,
        sgbstdn_degc_code_1,
        sgbstdn_majr_code_conc_1,
        sgbstdn_majr_code_conc_1_2,
        sgbstdn_majr_code_conc_1_3,
        sgbstdn_coll_code_2,
        sgbstdn_degc_code_2,
        sgbstdn_majr_code_conc_2,
        sgbstdn_majr_code_conc_2_2,
        sgbstdn_majr_code_conc_2_3,
        sgbstdn_orsn_code,
        sgbstdn_prac_code,
        sgbstdn_advr_pidm,
        sgbstdn_grad_credit_appr_ind,
        sgbstdn_capl_code,
        sgbstdn_leav_code,
        sgbstdn_leav_from_date,
        sgbstdn_leav_to_date,
        sgbstdn_astd_code,
        sgbstdn_term_code_astd,
        sgbstdn_rate_code,
        sgbstdn_activity_date,
        sgbstdn_gorg_code,
        sgbstdn_edlv_code,
        sgbstdn_incm_code,
        sgbstdn_admt_code,
        sgbstdn_emex_code,
        sgbstdn_aprn_code,
        sgbstdn_trcn_code,
        sgbstdn_gain_code,
        sgbstdn_voed_code,
        sgbstdn_regp_code,
        sgbstdn_rfrom_date,
        sgbstdn_rfrom_time,
        sgbstdn_ruser,
        sgbstdn_rcat_code,
        sgbstdn_regp_act_date,
        sgbstdn_blck_code,
        sgbstdn_term_code_grad,
        sgbstdn_acyr_code,
        sgbstdn_rstr_code,
        sgbstdn_dept_code,
        sgbstdn_site_code,
        sgbstdn_dept_code_2,
        sgbstdn_egol_code,
        sgbstdn_degc_code_dual,
        sgbstdn_levl_code_dual,
        sgbstdn_dept_code_dual,
        sgbstdn_coll_code_dual,
        sgbstdn_majr_code_dual,
        sgbstdn_bskl_code,
        sgbstdn_prim_roll_ind,
        sgbstdn_program_1,
        sgbstdn_term_code_ctlg_1,
        sgbstdn_dept_code_1_2,
        sgbstdn_majr_code_conc_121,
        sgbstdn_majr_code_conc_122,
        sgbstdn_majr_code_conc_123,
        sgbstdn_secd_roll_ind,
        sgbstdn_term_code_admit_2,
        sgbstdn_admt_code_2,
        sgbstdn_program_2,
        sgbstdn_term_code_ctlg_2,
        sgbstdn_levl_code_2,
        sgbstdn_camp_code_2,
        sgbstdn_dept_code_2_2,
        sgbstdn_majr_code_conc_221,
        sgbstdn_majr_code_conc_222,
        sgbstdn_majr_code_conc_223,
        sgbstdn_curr_rule_1,
        sgbstdn_cmjr_rule_1_1,
        sgbstdn_ccon_rule_11_1,
        sgbstdn_ccon_rule_11_2,
        sgbstdn_ccon_rule_11_3,
        sgbstdn_cmjr_rule_1_2,
        sgbstdn_ccon_rule_12_1,
        sgbstdn_ccon_rule_12_2,
        sgbstdn_ccon_rule_12_3,
        sgbstdn_cmnr_rule_1_1,
        sgbstdn_cmnr_rule_1_2,
        sgbstdn_curr_rule_2,
        sgbstdn_cmjr_rule_2_1,
        sgbstdn_ccon_rule_21_1,
        sgbstdn_ccon_rule_21_2,
        sgbstdn_ccon_rule_21_3,
        sgbstdn_cmjr_rule_2_2,
        sgbstdn_ccon_rule_22_1,
        sgbstdn_ccon_rule_22_2,
        sgbstdn_ccon_rule_22_3,
        sgbstdn_cmnr_rule_2_1,
        sgbstdn_cmnr_rule_2_2,
        sgbstdn_prev_code,
        sgbstdn_term_code_prev,
        sgbstdn_cast_code,
        sgbstdn_term_code_cast,
        sgbstdn_data_origin,
        sgbstdn_user_id,
        sgbstdn_scpc_code,
        sgbstdn_surrogate_id,
        sgbstdn_version,
        sgbstdn_vpdi_code
        */