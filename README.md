# Telcomax Customer Churn Analysis
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

**2.Exploratory Data Analysis (EDA):**

- Analyzed overall churn rate and segmented churn rates by various customer attributes including gender, tenure, dependents, and senior citizen status.
- Generated key insights, such as higher churn rates among new customers, senior citizens, and customers without partners or dependents.
- Calculated average tenure and monthly charges for churned vs. non-churned customers.

**3.Data Visualization and Reporting:**

- Developed interactive dashboards in Power BI to visualize churn analysis, including bar charts, matrix tables, and KPI visuals.
- Created measures in DAX for advanced calculations such as churn rates, average tenure, and total monthly charges.
- Incorporated detailed views of customer segments by tenure groups and dependents to highlight specific areas of concern.

**4.Recommendations:**

Formulated actionable recommendations based on data insights to reduce churn and enhance customer retention.
Suggested targeted retention strategies for high-risk segments such as new customers, senior citizens, and customers without partners.
Proposed loyalty programs, personalized offers, and enhanced customer support initiatives to address identified churn drivers.

## Tools and Technologies:

- SQL for data extraction and transformation
- Power BI for data visualization and reporting
- DAX for creating measures and advanced calculations
- Excel for supplementary data analysis
