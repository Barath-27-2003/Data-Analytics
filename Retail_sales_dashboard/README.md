# Retail Sales Analysis Dashboard — Power BI

An interactive Power BI dashboard analyzing retail sales performance across regions, product categories, and customer segments — built to surface KPIs, identify underperforming areas, and support data-driven merchandising decisions.

## 🎯 Business Problem
The business needed a single view to track sales, profit, and discount impact across regions and categories, and to quickly spot which product lines and cities were underperforming each quarter.

## 📊 Dataset
- `data/retail_sales_data.csv` — 4,000 order-level transactions (Jan 2024 – Dec 2025)
- Fields: Order ID, Order/Ship Date, Region, City, Category, Product, Customer Segment, Quantity, Unit Price, Discount, Sales, Profit

## 🛠️ Tools & Techniques
- **Power Query** — data cleaning, type conversions, date table creation
- **Data Modeling** — star schema (Fact_Sales linked to Dim_Date, Dim_Product, Dim_Region, Dim_Customer)
- **DAX** — calculated measures for KPIs, YoY growth, running totals
- **Power BI Service** — row-level security, scheduled refresh

## 📈 Key Metrics (DAX Measures)
- Total Sales, Total Profit, Profit Margin %
- YoY Sales Growth
- Average Discount Rate
- Sales by Region / Category / Segment
- Top 10 Products by Profit

## 🖼️ Dashboard Preview
![Overview](screenshots/overview.png)
![KPI Drilldown](screenshots/kpi_drilldown.png)

## 🔍 Key Insights
- Add 2–3 bullet points here once you've explored your own dashboard — e.g. which region/category drives the most profit, where discounting is eroding margin, seasonal patterns, etc.

## 📂 Repo Structure
```
retail-sales-dashboard/
├── README.md
├── data/
│   └── retail_sales_data.csv
├── dashboard/
│   └── Retail_Sales_Dashboard.pbix
├── screenshots/
│   ├── overview.png
│   └── kpi_drilldown.png
└── dax/
    └── measures.txt
```

## 🚀 How to Use
1. Clone this repo
2. Open `dashboard/Retail_Sales_Dashboard.pbix` in Power BI Desktop
3. Refresh the data source if prompted (points to `data/retail_sales_data.csv`)

## 👤 Author
Barathraj S — [LinkedIn](https://www.linkedin.com/in/%20barathraj-s-68b928248) | [GitHub](https://github.com/Barath-27-2003)
