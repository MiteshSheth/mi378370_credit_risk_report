-------------Loading Reporting Tables ----------------

use {{ params.hive_schema }};

INSERT OVERWRITE TABLE portfolio_summary_report 
SELECT division_name,
sum(current_exp),
sum(potential_exp),
sum(exposure1),
sum(exposure2),
sum(LME) 
FROM credit_risk_aggregate
group by division_name;

INSERT OVERWRITE TABLE counterparty_list_report 
SELECT cp_id,
sum(current_exp),
sum(potential_exp),
country_name,
rating_name,
industry_name 
FROM credit_risk_aggregate 
group by cp_id,country_name,rating_name,industry_name;