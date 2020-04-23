use {{ params.hive_schema }};

-----------------Staging Tables-----------------
--------------investment_banking_ce_stage ------------------------
CREATE TABLE IF NOT EXISTS investment_banking_ce_stage
(cp_id string,
cp_name string,
rating_id string,
country_id string,
industry_id string,
division_id string,
current_exp string,
exposure1 string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
TBLPROPERTIES(
"skip.header.line.count"="1",
'serialization.null.format'='');

----------------investment_banking_pe_stage ------------------------
CREATE TABLE IF NOT EXISTS investment_banking_pe_stage
(cp_id string,
cp_name string,
rating_id string,
country_id string,
industry_id string,
division_id string,
potential_exp string,
exposure2 string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
TBLPROPERTIES(
"skip.header.line.count"="1",
'serialization.null.format'='');

--------------private_banking_ce_stage ------------------------
CREATE TABLE IF NOT EXISTS private_banking_ce_stage
(cif_id string,
cif_name string,
cp_id string,
cp_name string,
rating_id string,
country_id string,
industry_id string,
division_id string,
current_exp string,
exposure1 string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
TBLPROPERTIES(
"skip.header.line.count"="1",
'serialization.null.format'='');

-------------private_banking_pe_stage ----------------
CREATE TABLE IF NOT EXISTS private_banking_pe_stage
(cif_id string,
cif_name string,
cp_id string,
cp_name string,
rating_id string,
country_id string,
industry_id string,
division_id string,
potential_exp string,
exposure2 string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
TBLPROPERTIES(
"skip.header.line.count"="1",
'serialization.null.format'='');

--------------industry_ref_stage ----------------
CREATE TABLE IF NOT EXISTS industry_ref_stage
(industry_id string,
industry_name string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
TBLPROPERTIES(
"skip.header.line.count"="1",
'serialization.null.format'='');

--------------country_ref_stage ----------------
CREATE TABLE IF NOT EXISTS  country_ref_stage
(country_id string,
country_name string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
TBLPROPERTIES(
"skip.header.line.count"="1",
'serialization.null.format'='');

---------------------division_ref_stage --------
CREATE TABLE IF NOT EXISTS  division_ref_stage
(division_id string,
division_name string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
TBLPROPERTIES(
"skip.header.line.count"="1",
'serialization.null.format'='');

--------------rating_ref_stage ----------------
CREATE TABLE IF NOT EXISTS  rating_ref_stage
(rating_id string,
rating_name string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
TBLPROPERTIES(
"skip.header.line.count"="1",
'serialization.null.format'='');

-----------------Target Tables-----------------
--------------investment_banking_ce_t ------------------------
CREATE TABLE IF NOT EXISTS investment_banking_ce_t
(cp_id string,
cp_name string,
rating_id string,
country_id string,
industry_id string,
division_id string,
current_exp decimal(10,2),
exposure1 decimal(10,2))
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
TBLPROPERTIES(
'serialization.null.format'='');

----------------investment_banking_pe_t ------------------------
CREATE TABLE IF NOT EXISTS investment_banking_pe_t
(cp_id string,
cp_name string,
rating_id string,
country_id string,
industry_id string,
division_id string,
potential_exp decimal(10,2),
exposure2 decimal(10,2))
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
TBLPROPERTIES(
'serialization.null.format'='');

--------------private_banking_ce_t ------------------------
CREATE TABLE IF NOT EXISTS private_banking_ce_t
(cif_id string,
cif_name string,
cp_id string,
cp_name string,
rating_id string,
country_id string,
industry_id string,
division_id string,
current_exp decimal(10,2),
exposure1 decimal(10,2))
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
TBLPROPERTIES(
'serialization.null.format'='');

-------------- private_banking_pe_t ----------------
CREATE TABLE IF NOT EXISTS private_banking_pe_t
(cif_id string,
cif_name string,
cp_id string,
cp_name string,
rating_id string,
country_id string,
industry_id string,
division_id string,
potential_exp decimal(10,2),
exposure2 decimal(10,2))
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
TBLPROPERTIES(
'serialization.null.format'='');

--------------industry_ref_t ----------------
CREATE TABLE IF NOT EXISTS industry_ref_t
(industry_id string,
industry_name string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
TBLPROPERTIES(
'serialization.null.format'='');

--------------country_ref_t ----------------
CREATE TABLE IF NOT EXISTS  country_ref_t
(country_id string,
country_name string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
TBLPROPERTIES(
'serialization.null.format'='');

---------------------division_ref_t --------
CREATE TABLE IF NOT EXISTS  division_ref_t
(division_id string,
division_name string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
TBLPROPERTIES(
'serialization.null.format'='');

--------------rating_ref_t ----------------
CREATE TABLE IF NOT EXISTS  rating_ref_t
(rating_id string,
rating_name string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
TBLPROPERTIES(
'serialization.null.format'='');

--------------Harmonised Table--------------

CREATE TABLE IF NOT EXISTS credit_risk_harmonized_private_banking(
cp_id string,
cp_name string,
rating_id string,
rating_name string,
country_id string,
country_name string,
industry_id string,
industry_name string,
division_id string,
division_name string,
system_type string,
current_exp decimal(10,2),
exposure1 decimal(10,2),
potential_exp decimal(10,2),
exposure2 decimal(10,2))
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
TBLPROPERTIES(
'serialization.null.format'='');

CREATE TABLE IF NOT EXISTS credit_risk_harmonized_investment_banking(
cp_id string,
cp_name string,
rating_id string,
rating_name string,
country_id string,
country_name string,
industry_id string,
industry_name string,
division_id string,
division_name string,
system_type string,
current_exp decimal(10,2),
exposure1 decimal(10,2),
potential_exp decimal(10,2),
exposure2 decimal(10,2))
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
TBLPROPERTIES(
'serialization.null.format'='');

-------------- Aggregate Table ------------------

CREATE TABLE IF NOT EXISTS credit_risk_aggregate(
cp_id string,
cp_name string,
rating_id string,
rating_name string,
country_id string,
country_name string,
industry_id string,
industry_name string,
division_id string,
division_name string,
system_type string,
current_exp decimal(10,2),
exposure1 decimal(10,2),
potential_exp decimal(10,2),
exposure2 decimal(10,2),
LME decimal(10,2))
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
TBLPROPERTIES(
'serialization.null.format'='');

--------------------- Final Report tables-------------------
CREATE EXTERNAL TABLE IF NOT EXISTS portfolio_summary_report( 
division string,
current_exp double ,
potential_exp double,
exposure1 double,
exposure2 double, 
LME double) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE
LOCATION '{{ params.output_path }}/portfolio_summary_report'
TBLPROPERTIES(
'serialization.null.format'='');

CREATE EXTERNAL TABLE IF NOT EXISTS counterparty_list_report(
counterparty string,
current_exp double, 
potential_exp double, 
country string,
rating string,
industry string) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE
LOCATION '{{ params.output_path }}/counterparty_list_report'
TBLPROPERTIES(
'serialization.null.format'='');