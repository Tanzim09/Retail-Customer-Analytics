# Retail Customer Analytics Project

## Project Overview

This project focuses on analyzing **retail customer transactions** to gain insights into customer behavior, sales trends, churn prediction, and customer lifetime value (CLV). The analysis incorporates **Python, SQL, and Power BI** to derive business insights and improve decision-making.

Key aspects covered:

- **Customer segmentation** using clustering
- **Churn prediction** with machine learning
- **Customer Lifetime Value (CLV) estimation**
- **Sales & revenue trend analysis**
- **SQL-based transactional analysis**
- **Power BI dashboard for visualization**

## Key Technologies & Skills Used

- **Python**: Data cleaning, feature engineering, exploratory data analysis
- **SQL**: Writing complex queries for business insights
- **Machine Learning**: K-Means Clustering, BG/NBD, Gamma-Gamma, Logistic Regression
- **Power BI**: Interactive dashboard design and visualization
- **Pandas, NumPy, Matplotlib, Seaborn**: Data processing and visualization
- **Scikit-Learn & Lifetimes Library**: ML model training and CLV estimation

---

## Project Workflow

### 1. Data Understanding & Preprocessing

- Loaded **1M+ transactions** from CSV files.
- Cleaned missing values, standardized product lists, and derived new features.
- Converted transaction timestamps to structured formats (year, month, day, hour).

### 2. Exploratory Data Analysis (EDA)

- Identified top-selling products, peak shopping hours, and payment trends.
- Analyzed store performance and customer spending behavior.

### 3. Customer Segmentation (K-Means Clustering)

- Used **K-Means** to segment customers into 4 groups:
  - **Low Spenders (Infrequent Buyers)**
  - **Mid-Spenders (Regular Shoppers)**
  - **Frequent Shoppers with High Spending**
  - **Occasional Buyers with Higher Order Value**
- Visualized clusters using **scatter plots and bar charts**.

### 4. Customer Lifetime Value (CLV) Prediction

- Applied **BG/NBD** model to estimate future purchases.
- Used **Gamma-Gamma** model to predict spending per transaction.
- Estimated **total lifetime value (CLV)** per customer.

### 5. Customer Churn Prediction

- Engineered churn-related features: **recency, frequency, monetary value**.
- Trained **Logistic Regression** to predict customer churn.
- Improved model by adding **spending variability and days between purchases**.

### 6. SQL-Based Business Insights

- Wrote **20+ SQL queries** to analyze:
  - **Sales performance** by store and city.
  - **Customer retention trends**.
  - **Discount effectiveness** on purchase behavior.
  - **High-value customer transactions**.

### 7. Power BI Dashboard

- Developed an **interactive dashboard** covering:
  - **Sales Trends** (hourly, daily, monthly)
  - **Customer Segments & Spending Behavior**
  - **Revenue by Store Type & City**
  - **Churn Analysis**
  - **Top Customers & Payment Methods**

---

## Key Visualizations in Power BI

1. **Sales Trends Over Time** (Line Charts)
2. **Top-Selling Products** (Bar Chart)
3. **Customer Segments by Spending Pattern** (Clustered Bar Chart)
4. **Revenue Contribution by Store Type** (Stacked Bar Chart)
5. **Total Revenue by City & Year** (Stacked Column Chart)
6. **% of Orders by Payment Method** (Donut Chart)
7. **Discount Utilization & Impact on Sales** (Stacked Bar Chart)

---

## How to Use

### Python Code Execution

- Open the Jupyter Notebooks (`.ipynb`) and execute step by step.
- Required libraries: `pandas`, `numpy`, `seaborn`, `matplotlib`, `sklearn`, `lifetimes`.

### SQL Queries

- Run the SQL scripts in **SSMS or any SQL editor** after loading the cleaned dataset.

### Power BI Dashboard

- Open **`Retail_Customer_Analytics.pbix`** in **Power BI** to interact with visual insights.

---

## Folder Structure

```
Retail-Customer-Analytics/
│── dashboard/
│   ├── Retail_Customer_Analytics.pbix  # Power BI dashboard file
│
│── dashboard_screenshots/
│   ├── dashboard_page-1.png  # Screenshot of first dashboard page
│   ├── dashboard_page-2.png  # Screenshot of second dashboard page
│
│── data/
│   ├── churn_analysis.zip  # Data related to churn analysis
│   ├── churn_summary.zip  # Summary statistics of churn data
│   ├── cleaned_transactions.zip  # Processed transaction data
│   ├── clv_data.zip  # Data related to Customer Lifetime Value (CLV)
│   ├── customer_segmentation_guide.txt  # Documentation for segmentation process
│   ├── customer_segments.zip  # Processed customer segmentation data
│   ├── Retail_Transactions_Dataset.zip  # Raw retail transaction data
│
│── notebooks (preprocessing + EDA + models)/
│   ├── 01_data_understanding.ipynb  # Initial data exploration
│   ├── 02_eda_analysis.ipynb  # Exploratory Data Analysis (EDA)
│   ├── 03_customer_segmentation.ipynb  # Clustering and segmentation models
│   ├── 04_customer_lifetime_value.ipynb  # Predicting customer lifetime value
|   |── 05
```


---

### 📢 Contributors & Contact

👤 **Tanzim Rafat**  
📧 ****  
🔗 **[GitHub Repository](https://github.com/yourusername/Retail-Customer-Analytics)**

---

This project provides **actionable insights** into retail sales, customer behavior, and predictive analytics. The combination of **Python, SQL, Machine Learning, and Power BI** makes it an excellent **data-driven business solution**! 🚀
