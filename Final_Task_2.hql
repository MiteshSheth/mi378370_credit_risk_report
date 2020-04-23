use {{ params.hive_schema }};

-------------- Loading Stage Tables ------------------
LOAD DATA LOCAL INPATH '{{ params.input_path }}/Division_Ref.txt' OVERWRITE INTO TABLE division_ref_stage ;
LOAD DATA LOCAL INPATH '{{ params.input_path }}/Country_Ref.txt' OVERWRITE INTO TABLE country_ref_stage ;
LOAD DATA LOCAL INPATH '{{ params.input_path }}/Industry_Ref.txt' OVERWRITE INTO TABLE industry_ref_stage ;
LOAD DATA LOCAL INPATH '{{ params.input_path }}/Rating_Ref.txt' OVERWRITE INTO TABLE rating_ref_stage ;
LOAD DATA LOCAL INPATH '{{ params.input_path }}/IB_CE.txt' OVERWRITE INTO TABLE investment_banking_ce_stage ;
LOAD DATA LOCAL INPATH '{{ params.input_path }}/IB_PE.txt' OVERWRITE INTO TABLE investment_banking_pe_stage ;
LOAD DATA LOCAL INPATH '{{ params.input_path }}/PB_CE.csv' OVERWRITE INTO TABLE private_banking_ce_stage ;
LOAD DATA LOCAL INPATH '{{ params.input_path }}/PB_PE.csv' OVERWRITE INTO TABLE private_banking_pe_stage ;

------------- Loading Target Table ---------------------
INSERT OVERWRITE TABLE division_ref_t SELECT * FROM division_ref_stage WHERE division_id IS NOT NULL;
INSERT OVERWRITE TABLE country_ref_t SELECT * FROM country_ref_stage WHERE country_id IS NOT NULL; 
INSERT OVERWRITE TABLE industry_ref_t SELECT * FROM industry_ref_stage WHERE industry_id IS NOT NULL;
INSERT OVERWRITE TABLE rating_ref_t SELECT * FROM rating_ref_stage WHERE rating_id IS NOT NULL;
INSERT OVERWRITE TABLE investment_banking_ce_t SELECT * FROM investment_banking_ce_stage WHERE current_exp is not null and exposure1 IS NOT NULL;
INSERT OVERWRITE TABLE investment_banking_pe_t SELECT * FROM investment_banking_pe_stage WHERE potential_exp is not null and exposure2 IS NOT NULL;
INSERT OVERWRITE TABLE private_banking_ce_t SELECT * FROM private_banking_ce_stage WHERE current_exp is not null and exposure1 IS NOT NULL and cp_id IS NOT NULL;
INSERT OVERWRITE TABLE private_banking_pe_t SELECT * FROM private_banking_pe_stage WHERE potential_exp is not null and exposure2 IS NOT NULL;