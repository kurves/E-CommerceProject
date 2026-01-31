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

Data model

![](https://github.com/kurves/E-CommerceProject/blob/main/projectimages/model.PNG)

## 🛠 Tools Used
- SQL (data modeling & analysis)
- Power BI (dashboards & visualization)
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
