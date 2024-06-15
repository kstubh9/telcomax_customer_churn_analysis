SELECT * FROM telco_customer_churn
SELECT *
FROM telco_customer_churn
GROUP BY customerID
HAVING COUNT(*) > 1;


--Handle missing values
UPDATE telco_customer_churn SET TotalCharges = 0 WHERE TotalCharges IS NULL;

--Convert categorical variables
ALTER TABLE telco_customer_churn
ADD PartnerNumeric INT, DependentsNumeric INT;

UPDATE telco_customer_churn SET
  PartnerNumeric = CASE WHEN Partner = 'Yes' THEN 1 ELSE 0 END,
  DependentsNumeric = CASE WHEN Dependents = 'Yes' THEN 1 ELSE 0 END;

SELECT 
	COLUMN_NAME, DATA_TYPE 
FROM 
	INFORMATION_SCHEMA.COLUMNS 
WHERE	
	TABLE_NAME = 'telco_customer_churn'


CREATE VIEW cleaned_telco_churn AS
SELECT 
	CAST(customerID as VARCHAR(100)) as customer_id,
	gender,
	PartnerNumeric as partner,
	DependentsNumeric as dependents,
	CAST(SeniorCitizen as VARCHAR(100)) as senior_citizen,
	CAST(tenure as INT) as tenure,
	MonthlyCharges as monthly_charges,
	TotalCharges as total_charges,
	Churn 
FROM 
	telco_customer_churn


