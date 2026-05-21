# superstore-sales-analysis

# Overview
End-to-end data analysis project using 4 years of US retail transaction data (2014–2017).
The goal was to uncover revenue patterns, identify loss-making products, and understand which customer segments and regions drive the most value.
# Tools used: PostgreSQL · pgAdmin · Tableau Public

# Business Questions Answered
All 12 queries are in `/sql/superstore_sales_analysis.sql`

# Key Findings
# Revenue & Profitability
Total revenue across 4 years: $2.3M with consistent year-over-year growth
November spikes every year — clear seasonal pattern driven by holiday shopping
Technology is the highest revenue category but Office Supplies has the best profit margin
Tables sub-category lost -$17,726 — the biggest loss-maker in the dataset, driven by excessive discounting

# Customer Insights
Consumer segment accounts for 50.56% of total revenue — the dominant segment
Corporate brings 30.74% and Home Office 18.70%
Top customer (Sean Miller) generated over $25,000 in lifetime value
Majority of customers are repeat buyers — strong retention signal

# Regional Performance
California and New York are the top two states by sales volume
Central region struggles most with profitability despite decent sales volume
Several states including Texas and Illinois show negative profit — discount abuse identified as the primary cause

# Dashboard
📊 View Live Dashboard on Tableau Public
https://public.tableau.com/app/profile/shraddha.ingle/viz/Book2_17793855933850/Dashboard1?publish=yes

# How to Run
1.Download the dataset from Kaggle — Superstore Dataset

2.Load into PostgreSQL using the setup instructions below

3.Run any .sql file in pgAdmin Query Tool

4.Open the Tableau Public dashboard for interactive exploration

# Dataset
Source: Kaggle — Superstore Dataset Final

Rows: 9,994 orders

Period: January 2014 – December 2017

Geography: United States

Fields: Order details, customer info, product categories, sales, profit, discount, shipping
