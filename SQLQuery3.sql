-- Checked for duplicates, missing values and data types

-- Overall Churn Rate

SELECT
  COUNT(*) AS total_customers,
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(CAST(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100, 2) AS churn_rate
FROM 
	cleaned_telco_churn;

-- Churn Rate by Gender

SELECT 
	gender,
	COUNT(*) AS total_customers,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
	ROUND(CAST(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100, 2) AS churn_rate
FROM 
	cleaned_telco_churn
GROUP BY 
	gender;

-- Churn Rate by Tenure

SELECT 
	tenure,
	COUNT(*) AS total_customers,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
	ROUND(CAST(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100, 2) AS churn_rate
FROM 
	cleaned_telco_churn
GROUP BY 
	tenure
ORDER BY 
	tenure DESC;

-- Average Tenure of Churned vs. Non-Churned Customers

SELECT 
    Churn, 
    AVG(tenure) AS avg_tenure
FROM 
    cleaned_telco_churn
GROUP BY 
    Churn;

-- Average Monthly Charges Distribution for Churned vs. Non-Churned Customers

SELECT 
    Churn, 
    ROUND(AVG(monthly_charges), 2) AS avg_monthly_charges
FROM 
    cleaned_telco_churn
GROUP BY 
    Churn;

-- Churn rate by Senior Citizen Status

SELECT 
    senior_citizen,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(CAST(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) as FLOAT) / COUNT(*) * 100, 2) AS churn_rate
FROM 
    cleaned_telco_churn
GROUP BY 
    senior_citizen;

-- Churn Rate by Partner Status
SELECT 
    partner,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(CAST(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) as FLOAT) / COUNT(*) * 100, 2) AS churn_rate
FROM 
    cleaned_telco_churn
GROUP BY 
    partner;


-- Churn Rate by Dependents
SELECT 
    dependents,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(CAST(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) as FLOAT) / COUNT(*) * 100, 2) AS churn_rate
FROM 
    cleaned_telco_churn
GROUP BY 
    dependents;

-- Total Monthly Charges by Churn Status
SELECT 
    Churn,
    ROUND(SUM(monthly_charges), 2) AS total_monthly_charges
FROM 
    cleaned_telco_churn
GROUP BY 
    Churn;
 
--  Total Charges by Churn Status
 SELECT 
    Churn,
    SUM(total_charges) AS total_charges
FROM 
    cleaned_telco_churn
GROUP BY 
    Churn;

-- Average Monthly Charges and Churn Rate by Tenure Group

SELECT 
    CASE 
        WHEN tenure <= 12 THEN '0-12 months'
        WHEN tenure <= 24 THEN '13-24 months'
        WHEN tenure <= 36 THEN '25-36 months'
        WHEN tenure <= 48 THEN '37-48 months'
        WHEN tenure <= 60 THEN '49-60 months'
        ELSE '61+ months'
    END AS tenure_group,
    ROUND(AVG(monthly_charges), 2) AS avg_monthly_charges,
	COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(CAST(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100, 2) AS churn_rate
FROM 
    cleaned_telco_churn
GROUP BY 
    CASE 
        WHEN tenure <= 12 THEN '0-12 months'
        WHEN tenure <= 24 THEN '13-24 months'
        WHEN tenure <= 36 THEN '25-36 months'
        WHEN tenure <= 48 THEN '37-48 months'
        WHEN tenure <= 60 THEN '49-60 months'
        ELSE '61+ months'
    END
ORDER BY
	tenure_group;

-- Churn Rate and Average Monthly Charges by Tenure Group and Gender

SELECT 
    gender,
    CASE 
        WHEN tenure <= 12 THEN '0-12 months'
        WHEN tenure <= 24 THEN '13-24 months'
        WHEN tenure <= 36 THEN '25-36 months'
        WHEN tenure <= 48 THEN '37-48 months'
        WHEN tenure <= 60 THEN '49-60 months'
        ELSE '61+ months'
    END AS tenure_group,
    ROUND(AVG(monthly_charges), 2) AS avg_monthly_charges,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(CAST(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100, 2) AS churn_rate
FROM 
    cleaned_telco_churn
GROUP BY 
    Gender,
    CASE 
        WHEN tenure <= 12 THEN '0-12 months'
        WHEN tenure <= 24 THEN '13-24 months'
        WHEN tenure <= 36 THEN '25-36 months'
        WHEN tenure <= 48 THEN '37-48 months'
        WHEN tenure <= 60 THEN '49-60 months'
        ELSE '61+ months'
    END
ORDER BY 
    tenure_group,
    Gender;

-- Pivot Churn Rate and Average Monthly Charges by Tenure Group and Gender

SELECT 
    CASE 
        WHEN tenure <= 12 THEN '0-12 months'
        WHEN tenure <= 24 THEN '13-24 months'
        WHEN tenure <= 36 THEN '25-36 months'
        WHEN tenure <= 48 THEN '37-48 months'
        WHEN tenure <= 60 THEN '49-60 months'
        ELSE '61+ months'
    END AS tenure_group,
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN monthly_charges ELSE NULL END), 2) AS avg_monthly_charges_female,
    ROUND(AVG(CASE WHEN Gender = 'Male' THEN monthly_charges ELSE NULL END), 2) AS avg_monthly_charges_male,
    COUNT(CASE WHEN Gender = 'Female' THEN 1 ELSE NULL END) AS total_customers_female,
    COUNT(CASE WHEN Gender = 'Male' THEN 1 ELSE NULL END) AS total_customers_male,
    SUM(CASE WHEN Gender = 'Female' AND Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers_female,
    SUM(CASE WHEN Gender = 'Male' AND Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers_male,
    ROUND(CAST(SUM(CASE WHEN Gender = 'Female' AND Churn = 'Yes' THEN 1 ELSE 0 END) AS FLOAT) / 
          COUNT(CASE WHEN Gender = 'Female' THEN 1 ELSE NULL END) * 100, 2) AS churn_rate_female,
    ROUND(CAST(SUM(CASE WHEN Gender = 'Male' AND Churn = 'Yes' THEN 1 ELSE 0 END) AS FLOAT) / 
          COUNT(CASE WHEN Gender = 'Male' THEN 1 ELSE NULL END) * 100, 2) AS churn_rate_male
FROM 
    cleaned_telco_churn
GROUP BY 
    CASE 
        WHEN tenure <= 12 THEN '0-12 months'
        WHEN tenure <= 24 THEN '13-24 months'
        WHEN tenure <= 36 THEN '25-36 months'
        WHEN tenure <= 48 THEN '37-48 months'
        WHEN tenure <= 60 THEN '49-60 months'
        ELSE '61+ months'
    END
ORDER BY 
    tenure_group;



 
	









