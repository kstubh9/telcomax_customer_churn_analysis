# Telcomax Customer Churn Analysis
![Page 2](https://github.com/kstubh9/telcomax_customer_churn_analysis/assets/82211890/4f4fe353-60a7-4186-a0f2-f87f076d0583)

## Problem Statement
TelcoMax is a leading telecommunications provider offering a wide range of services including internet, television, and mobile phone plans. Despite a robust customer base, TelcoMax has been experiencing a noticeable rate of customer churn, which is adversely affecting its revenue growth and market position. Understanding the factors contributing to customer churn and identifying strategies to retain customers is crucial for the company’s long-term success.

TelcoMax aims to reduce customer churn and optimize revenue by gaining insights into the customer journey, identifying key indicators of churn, and developing targeted strategies to improve customer retention. The company is seeking a comprehensive analysis that integrates customer demographics and usage patterns to understand the churn behavior.

### Objectives 
**Analyze Customer Churn**: Determine the overall churn rate and identify customer segments with the highest churn rates.
**Identify Key Indicators**: Pinpoint factors such as tenure, monthly charges, and demographic details (e.g., gender, dependents, senior citizens) that are most strongly associated with churn.
**Evaluate Financial Impact**: Assess the total monthly charges lost due to churn and identify high-value customer segments at risk.
**Recommendations**: Provide actionable recommendations for reducing churn and improving customer retention strategies.

### Data Source
**Customer Demographics**: Information about customer age, gender, dependents, senior citizen status, etc.
**Service Details**: Monthly charges and tenure.
**Churn Status**: Indicator whether a customer has churned or not.

The relevant data is sourced from [Kaggle](https://www.kaggle.com/datasets/blastchar/telco-customer-churn).

## Responsibilities and Key Activities
Conduct a comprehensive analysis of customer churn to identify key drivers and develop strategies for improving customer retention at TelcoMax, a leading telecommunications provider.

**1. Data Extraction and Transformation:**

- Utilized SQL to extract relevant customer data from TelcoMax's database.
- Cleaned and transformed data using SQL queries and Power BI, ensuring data integrity and consistency.
- Created views and calculated columns to enrich the dataset with additional features such as tenure groups and dependent status.

**2. Exploratory Data Analysis (EDA):**

- Analyzed overall churn rate and segmented churn rates by various customer attributes including gender, tenure, dependents, and senior citizen status.
- Generated key insights, such as higher churn rates among new customers, senior citizens, and customers without partners or dependents.
- Calculated average tenure and monthly charges for churned vs. non-churned customers.

**3. Data Visualization and Reporting:**

- Developed interactive dashboards in Power BI to visualize churn analysis, including bar charts, matrix tables, and KPI visuals.
- Created measures in DAX for advanced calculations such as churn rates, average tenure, and total monthly charges.
- Incorporated detailed views of customer segments by tenure groups and dependents to highlight specific areas of concern.

**4. Recommendations:**

Formulated actionable recommendations based on data insights to reduce churn and enhance customer retention.
Suggested targeted retention strategies for high-risk segments such as new customers, senior citizens, and customers without partners.
Proposed loyalty programs, personalized offers, and enhanced customer support initiatives to address identified churn drivers.

## Tools and Technologies:

- SQL for data extraction and transformation
- Power BI for data visualization and reporting
- DAX for creating measures and advanced calculations
- Excel for supplementary data analysis

## Analysis
### SQL Queries
**1. Creating Database**
```sql
CREATE DATABASE telcomax_churn_analysis
USE telcomax_churn_analysis
```

**2. Cleaning and Transformation**
```sql
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
```

**3. Analysis**
```sql
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
```

### DAX Measures
Below are some of the DAX Measures used in the report.

**1. Average Tenure of Churned Customers**
```dax
Average Tenure of churned = CALCULATE([Total Tenure Churned]/[Count of churned])
```

**2. Average Tenure of Non-Churned Customers**
```dax
Average Tenure of Not churned = CALCULATE([Total Tenure Not Churned]/[Count of not churned])
```

**3. Average Monthly Charges of Churned Customers**
```dax
AvgMonthlyCharges_Churned = 
CALCULATE(
    AVERAGE(cleaned_telco_churn[monthly_charges]),
    cleaned_telco_churn[Churn] = "Yes"
)
```

**4. Average Monthly Charges of Non-Churned Customers**
```dax
AvgMonthlyCharges_NonChurned = 
CALCULATE(
    AVERAGE(cleaned_telco_churn[monthly_charges]),
    cleaned_telco_churn[Churn] = "No"
)
```

**5. Average Tenure of Churned Customers (in Months Format)**
```dax
AvgTenure_Churned = 
VAR Churned = 
    CALCULATE(
        AVERAGE(cleaned_telco_churn[tenure]),
        cleaned_telco_churn[Churn] = "Yes"
    )
RETURN 
    FORMAT(Churned, "0") & " Months"
```

**6. Churn Rate of Customers with Partners**
```dax
Churn Rate of customers having partners = 
DIVIDE([Churned customers having partners], [Total Customers having partners])
```

**7. Churn Rate of Customers without Partners**
```dax
Churn Rate of Customers Without Partners = DIVIDE([Churned customers not having partners], [Total Customers not having partners])
```

## Results
### Visualization
![Page 1](https://github.com/kstubh9/telcomax_customer_churn_analysis/assets/82211890/ea882125-a27b-4ed3-8d67-be0694dd30c5)

![Page 2](https://github.com/kstubh9/telcomax_customer_churn_analysis/assets/82211890/05ce0add-151e-455c-9f7b-fab6d427b7f4)

### Insights

![image](https://github.com/kstubh9/telcomax_customer_churn_analysis/assets/82211890/0e5a1e1b-0201-43f1-833a-5e9f3d24f826)

![image](https://github.com/kstubh9/telcomax_customer_churn_analysis/assets/82211890/a99e7c7c-9da0-4649-affc-bb09da27137a)

![image](https://github.com/kstubh9/telcomax_customer_churn_analysis/assets/82211890/3e825a75-cbfa-4922-9c65-eb8c7c5291c5)

![image](https://github.com/kstubh9/telcomax_customer_churn_analysis/assets/82211890/d116d2c1-1767-461a-9034-96c1e54acf2e)

![image](https://github.com/kstubh9/telcomax_customer_churn_analysis/assets/82211890/d73ba2a7-0089-4ad7-b082-9e8c7259c17f)

![image](https://github.com/kstubh9/telcomax_customer_churn_analysis/assets/82211890/f06bb47f-a505-40c9-9a6a-61b131b26411)

![image](https://github.com/kstubh9/telcomax_customer_churn_analysis/assets/82211890/32f84bcd-f9c6-4332-8b5a-2803bbbb1632) ![image](https://github.com/kstubh9/telcomax_customer_churn_analysis/assets/82211890/48256fcb-5b39-4890-a674-c6cac9bb211f)

![image](https://github.com/kstubh9/telcomax_customer_churn_analysis/assets/82211890/af984030-ebc3-4921-ad73-5f9eab09d688)

## Recommendations
**Enhance Customer Retention Strategies for New Customers:** The churn rate for customers within the first 12 months is extremely high at 47.44%. Implement onboarding programs, provide special offers, and maintain regular follow-ups during the initial months to increase engagement and satisfaction. Consider offering incentives such as discounts or added services to customers who stay beyond the first year.

**Focus on Retaining Senior Citizens:** Senior citizens have a significantly higher churn rate (41.68%) compared to non-senior citizens (23%). Develop targeted retention programs for senior citizens. This could include customized service plans, senior-friendly customer support, and loyalty programs. Regular check-ins and special promotions tailored to senior citizens could also help reduce churn.

**Support and Engage Customers Without Partners:** Customers without partners have a higher churn rate (32.96%) compared to those with partners (19.66%). Design campaigns to engage single customers, such as social events, community building activities, or personalized offers. Understanding the unique needs and preferences of single customers and addressing them can improve retention.

**Address High Churn Among Customers Without Dependents:** The churn rate for customers without dependents is higher (31.28%) than for those with dependents (15.45%). Investigate the reasons why customers without dependents are more likely to churn and develop targeted retention strategies. Consider providing benefits or services that appeal to individuals without dependents.

**Optimize Service Plans for Different Tenure Groups:** Average monthly charges vary significantly across different tenure groups, and churn rates decrease as tenure increases. Regularly review and optimize service plans to ensure they meet the evolving needs of customers as they stay longer. Introduce tiered loyalty programs that reward long-term customers with benefits like discounts, premium features, or exclusive services.

**Implement Strategies to Reduce Churn Among High-Charge Customers:** Churned customers have higher average monthly charges ($74.44) compared to non-churned customers ($61.27). Offer personalized retention programs for high-charge customers. This could include premium support, exclusive offers, or personalized service plans. Identifying and addressing the pain points of high-charge customers can help reduce churn.

**Strengthen Customer Support and Engagement:** The overall churn rate is 26.54%, indicating room for improvement in customer satisfaction and engagement. Invest in strengthening customer support and proactive engagement strategies. Regularly gather feedback, conduct satisfaction surveys, and act on the insights to continuously improve the customer experience. Personalized communication and prompt issue resolution can significantly enhance customer loyalty.

**Gender-Specific Retention Strategies:** The churn rate for female customers is slightly higher (26.92%) than for male customers (26.16%). Develop and implement gender-specific retention strategies. Understand the unique needs and preferences of female customers and address them through tailored communication, offers, and services.

## Key Achievements:

- Successfully identified and analyzed key factors contributing to customer churn.
- Developed and presented actionable insights and recommendations to TelcoMax’s management, enabling informed decision-making to improve customer retention strategies.
- Enhanced data analysis and visualization skills, providing clear and impactful business insights through interactive dashboards.

This project demonstrates a strong ability to handle end-to-end data analysis tasks, from data extraction and transformation to insightful reporting and actionable recommendations, showcasing proficiency in SQL, Power BI, and DAX.







