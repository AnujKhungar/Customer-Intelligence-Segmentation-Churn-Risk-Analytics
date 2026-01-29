Customer Intelligence: Segmentation & Churn Risk Analytics

Project Overview

Customer churn is one of the most critical challenges for subscription-based businesses.  
This project delivers an end-to-end customer intelligence solution that combines SQL, Python, 
and Power BI to identify churn drivers, segment customers, quantify revenue at risk, and 
support data-driven retention strategies.


Business Objectives
- Identify key factors contributing to customer churn
- Segment customers based on behavioral and revenue characteristics
- Quantify revenue at risk due to churn
- Enable stakeholders to prioritize high impact retention actions


Dataset
- Source: Public Telecom Customer Churn Dataset 
- Records: 7,000 customers
- Key Features:
  - Customer tenure
  - Contract type
  - Monthly & total charges
  - Service subscriptions
  - Churn indicator



Tools & Technologies

 -MySQL Data aggregation & churn analysis
 
 -Python(Pandas, NumPy, Scikit-learn), Feature engineering & customer segmentation 
 
 -Power BI(Interactive dashboard & business storytelling)



Analytical Approach

Phase 1: Business Understanding

Defined churn as a strategic risk metric impacting both revenue stability and customer lifetime value.


Phase 2: Feature Engineering & Segmentation (Python)

Created a customer level feature set including:
- Total revenue
- Tenure (months active)
- Average monthly spend
- Churn indicator

Applied K-Means clustering to segment customers into behaviorally distinct groups such as:
- High value loyal customers
- Price sensitive short tenure users
- High risk churn prone segments

Segment labels were assigned for interpretability during dashboarding.


Phase 3: SQL Analysis

Key SQL analyses included:
- Overall churn rate
- Churn by contract type
- Churn by tenure band
- Revenue at risk due to churn
- Segment level churn comparison


Phase 4: Power BI Dashboard
Designed a 3-page executive dashboard:

Executive Overview
- Total customers
- Churn rate
- Revenue at risk
- Churn by contract type & tenure

Customer Segmentation
- Segment distribution
- Churn rate by segment
- Segment performance table

Retention Strategy
- High-risk customer list
- Revenue risk by segment
- Interactive slicers for targeted analysis


Key Insights
- Month to month customers exhibit the highest churn rate
- Early tenure customers are significantly more likely to churn
- A small segment of customers contributes disproportionately to revenue at risk
- Targeted retention of high-value churn-prone customers can significantly reduce losses



Business Recommendations
- Introduce incentives for long term contracts
- Improve onboarding experience for new customers
- Deploy targeted retention campaigns for high value at risk segments
- Monitor churn KPIs monthly using the dashboard
