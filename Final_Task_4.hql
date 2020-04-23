-------------- Loading Aggregate table ----------------------
use {{ params.hive_schema }};

INSERT OVERWRITE TABLE credit_risk_aggregate 
SELECT 
cp_id,
cp_name,
rating_id,
rating_name,
country_id,
country_name,
industry_id,
industry_name,
division_id,
division_name,
system_type,
sum(current_exp),
sum(exposure1),
sum(potential_exp),
sum(exposure2),
Sum(current_exp+potential_exp) as LME 
FROM credit_risk_harmonized_private_banking where division_name is not null
group by cp_id,cp_name,rating_id,rating_name,country_id,country_name,industry_id,industry_name,division_id,division_name,system_type 
UNION ALL
SELECT 
cp_id,
cp_name,
rating_id,
rating_name,
country_id,
country_name,
industry_id,
industry_name,
division_id,
division_name,
system_type,
sum(current_exp),
sum(exposure1),
sum(potential_exp),
sum(exposure2),
Sum(current_exp+potential_exp) as LME 
FROM credit_risk_harmonized_investment_banking where division_name is not null
group by cp_id,cp_name,rating_id,rating_name,country_id,country_name,industry_id,industry_name,division_id,division_name,system_type;