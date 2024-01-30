#!/bin/bash
# (Key-columns) -  Row-check
dbt "show" --select "odsmgr_student__key_match"   
# Columns check
dbt "show" --select "odsmgr_student__honors_college_flag"
dbt "show" --select "odsmgr_student__packed_majors1"