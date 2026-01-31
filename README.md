# E-Commerce Analytics Project

## 📌 Project Overview
This project analyzes transactional and web data for an e-commerce business to identify revenue drivers, funnel drop-offs, customer retention patterns, and refund risks. 
This project implements a complete end-to-end analytics workflow, covering data modeling, ETL, KPI development, and visualization. This included designing and querying a relational database using PostgreSQL to model orders, customers, products, and transactions,  data extraction, cleaning, and transformation using Python (pandas, NumPy). Built core business KPIs including customer retention, repeat purchase rate, churn, revenue trends, and profitability metrics, Conducted cohort and funnel analysis to identify customer drop-off points and Developed interactive dashboards in Power BI to communicate insights to both technical and non-technical stakeholders.

## Executive Summary
## This project analyzes an e-commerce toy business across four dimensions:
- Business performance
- Funnel & conversion efficiency
- Customer retention & lifetime value
- Product refunds & operational risk


## 🧠 Business Questions
- What drives revenue growth?
- Where do users drop off in the purchase funnel?
- Are customers coming back?
- Which products have high refund risk?

## Data
This dataset was sourced from [Maven Analytics](https://app.mavenanalytics.io/datasets). 

![](https://github.com/kurves/E-CommerceProject/blob/main/projectimages/Capture2.PNG)

### Data Cleaning, Preparation and Modelling
I cleaned and prepared the data using Python, PostgreSQL and PowerBI
![](https://github.com/kurves/E-CommerceProject/blob/main/projectimages/data1.PNG)

### Data Modelling

I transformed raw transactional data into analytics-ready fact and dimension
tables, with curated SQL views built on top to support specific business questions
such as funnel conversion, customer retention, and product risk analysis.

### Star Schema Design

The data model follows a star schema to ensure:
- Clear metric definitions
- Consistent filtering across dashboards
- Scalable  analytical queries
  
- ### Fact Tables
- 
These ensure metrics are calculated once reused consistently.
Fact tables capture measurable business events:
- `fact_orders` – order-level revenue and profit
- `fact_order_items` – product-level sales and margins
- `fact_sessions` – user acquisition and traffic behavior
- `fact_refunds` – post-purchase revenue risk

### Dimension Tables
Dimension tables provide descriptive context:
- `dim_date` – standardized time analysis
- `dim_products` – product attributes
- `dim_users` – customer identity and lifecycle

##3 Analytical SQL Views

Rather than querying fact tables directly for every analysis, this project
introduces analytical SQL views that act as a semantic layer.

Each view is purpose-built to answer a specific business question while preserving
a clear and consistent grain.

### Examples

- `vw_exec_daily_performance`
  - Executive-level daily KPIs
  - Used for revenue, profit, and growth trends

- `vw_funnel_sessions_orders`
  - Session-to-order conversion analysis
  - Supports funnel and drop-off insights

- `vw_product_performance_monthly`
  - Product-level revenue, profit, refunds, and risk
  - Enables year/month filtering in Power BI

- `vw_customer_cohorts`
  - Cohort-based retention and LTV analysis


![](https://github.com/kurves/E-CommerceProject/blob/main/projectimages/model.PNG)

## 🛠 Tools Used
- SQL (data modeling & analysis)
  - Defining analytical grain
  - Joining and aggregating large datasets
  - Standardizing business metrics
- Power BI (dashboards & visualization)
  - Time-based comparisons (MoM, YoY)
  - Ratios and percentages
  - Interactive filtering and slicing
- Python (cohort & forecasting analysis)

## 📊 Key Insights

The analysis reveals that while traffic and revenue are growing, 
conversion inefficiencies, mobile friction, and product-specific refund risk 
are limiting long-term profitability.
- Repeat customers represent only 4.25% of the total revenue. This shows that acquistion is key fro this business rather than retention. Hence prioritize markting strategies aimed at new customers.
- The highest revenue contributor,  also has one of the highest refund rates. This suggests that while demand is strong, there may be issues related to product quality, customer expectations, or fulfillment that could negatively impact long-term profitability.

- A significant drop-off occurs between product views and add-to-cart events.
- While low-value users generate less revenue per customer, their high frequency and volume make them the primary contributors to total revenue.
- Organic traffic has highest conversion rate
- Refunded revenue represents a meaningful percentage of total product revenue.


## 📈 Dashboards
## Executive Overview
![](https://github.com/kurves/E-CommerceProject/blob/main/projectimages/dashboard1.PNG)

## Funnel and Conversion Analysis
![](https://github.com/kurves/E-CommerceProject/blob/main/projectimages/funnelanalysis.PNG)

## Customer retention and LTV analysis
![](https://github.com/kurves/E-CommerceProject/blob/main/projectimages/customeranalysis.PNG)

## Product and Refund Analysis
![](https://github.com/kurves/E-CommerceProject/blob/main/projectimages/refundriskdashboard.PNG)

## 🚀 Recommendations

- The conversion rate on mobile is low. UX/UI should be optimized to allow users to easily navigate and checkout.
- Improve product page clarity (pricing, delivery info, reviews).
- Test urgency cues such as low-stock indicators.
- Investigate refund reasons for this product.
- Review product descriptions, pricing, and quality controls for high refund-rate products.
- Track refund rate as a leading risk KPI.
- Introduce targeted upsell and loyalty initiatives for high-frequency users.
