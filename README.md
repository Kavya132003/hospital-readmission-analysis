# Hospital Readmission Risk Analysis

## Business Problem
Hospitals face financial penalties under CMS rules for excessive 30-day patient readmissions.
This project analyzes patient-level hospital encounter data to identify which factors
(demographics, admission details, clinical history) are most associated with 30-day
readmission risk, and provides recommendations for reducing it.

## Dataset
UCI "Diabetes 130-US hospitals for years 1999-2008" dataset (~100,000 encounters).
Source: https://archive.ics.uci.edu/dataset/296/diabetes+130-us+hospitals+for+years+1999-2008

## Project Structure
- `data/raw/` — original, untouched dataset
- `data/processed/` — cleaned dataset used for analysis
- `notebooks/` — Jupyter notebooks for cleaning, EDA, and modeling
- `sql/` — SQL scripts for aggregate/business queries
- `dashboard/` — Power BI dashboard file
- `README.md` — this file

## Workflow
1. Data cleaning (notebooks/01_data_cleaning.ipynb)
2. Exploratory data analysis (notebooks/02_eda.ipynb)
3. SQL business queries (sql/queries.sql)
4. Predictive modeling (notebooks/03_modeling.ipynb)
5. Dashboard (dashboard/readmission_dashboard.pbix)

## Key Findings
_(To be filled in as analysis progresses)_

## Recommendations
_(To be filled in as analysis progresses)_

## Author
Kavya — B.E. AI & ML, City Engineering College, Bengaluru
