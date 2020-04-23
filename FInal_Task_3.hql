use {{ params.hive_schema }};

------------------------ Inserting Data in Harmonized  Private Banking Table ----------------
INSERT OVERWRITE TABLE credit_risk_harmonized_private_banking 
SELECT 
pb_pe.cp_id,
pb_pe.cp_name,
pb_pe.rating_id,
r_ref.rating_name,
pb_pe.country_id,
c_ref.country_name,
pb_pe.industry_id,
i_ref.industry_name,
pb_pe.division_id,
d_ref.division_name,
"PB" AS system_type,
0 as current_exp,
0 as exposure1,
potential_exp,
exposure2 
FROM private_banking_pe_t pb_pe 
LEFT JOIN country_ref_t c_ref ON pb_pe.country_id = c_ref.country_id 
LEFT JOIN industry_ref_t i_ref ON pb_pe.industry_id = i_ref.industry_id 
LEFT JOIN division_ref_t d_ref ON pb_pe.division_id = d_ref.division_id 
LEFT JOIN rating_ref_t r_ref ON pb_pe.rating_id = r_ref.rating_id 
UNION All 
SELECT 
pb_ce.cp_id,
pb_ce.cp_name,
pb_ce.rating_id,
r_ref.rating_name,
pb_ce.country_id,
c_ref.country_name,
pb_ce.industry_id,
i_ref.industry_name,
pb_ce.division_id,
d_ref.division_name,
"PB" AS system_type,
current_exp,
exposure1,
0 as potential_exp,
0 as exposure2 
FROM private_banking_ce_t pb_ce 
LEFT JOIN country_ref_t c_ref ON pb_ce.country_id = c_ref.country_id 
LEFT JOIN industry_ref_t i_ref ON pb_ce.industry_id = i_ref.industry_id 
LEFT JOIN division_ref_t d_ref ON pb_ce.division_id = d_ref.division_id 
LEFT JOIN rating_ref_t r_ref ON pb_ce.rating_id = r_ref.rating_id ;

------------------------ Inserting Data in Harmonized  Investment Banking Table ----------------

INSERT OVERWRITE TABLE credit_risk_harmonized_investment_banking 
SELECT 
ib_pe.cp_id,
ib_pe.cp_name,
ib_pe.rating_id,
r_ref.rating_name,
ib_pe.country_id,
c_ref.country_name,
ib_pe.industry_id,
i_ref.industry_name,
ib_pe.division_id,
d_ref.division_name,
"IB" AS system_type,
0 as current_exp,
0 as exposure1,
potential_exp,
exposure2 
FROM investment_banking_pe_t ib_pe 
LEFT JOIN country_ref_t c_ref ON ib_pe.country_id = c_ref.country_id 
LEFT JOIN industry_ref_t i_ref ON ib_pe.industry_id = i_ref.industry_id 
LEFT JOIN division_ref_t d_ref ON ib_pe.division_id = d_ref.division_id 
LEFT JOIN rating_ref_t r_ref ON ib_pe.rating_id = r_ref.rating_id
UNION ALL 
SELECT 
ib_ce.cp_id,
ib_ce.cp_name,
ib_ce.rating_id,
r_ref.rating_name,
ib_ce.country_id,
c_ref.country_name,
ib_ce.industry_id,
i_ref.industry_name,
ib_ce.division_id,
d_ref.division_name,
"IB" AS system_type,
current_exp,
exposure1,
0 as potential_exp,
0 as exposure2 
FROM investment_banking_ce_t ib_ce 
LEFT JOIN country_ref_t c_ref ON ib_ce.country_id = c_ref.country_id 
LEFT JOIN industry_ref_t i_ref ON ib_ce.industry_id = i_ref.industry_id 
LEFT JOIN division_ref_t d_ref ON ib_ce.division_id = d_ref.division_id 
LEFT JOIN rating_ref_t r_ref ON ib_ce.rating_id = r_ref.rating_id;