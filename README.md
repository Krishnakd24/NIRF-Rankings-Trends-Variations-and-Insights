NIRF Ranking Analysis - Shiny App
Introduction
This interactive Shiny web application enables users to visualize and analyse the National Institutional Ranking Framework (NIRF) data from 2017 to 2025. The app explores institutional rankings across various metrics such as Teaching, Learning & Resources (TLR), Research & Professional Practice (RPC), Graduation Outcomes (GO), Outreach & Inclusivity (OI), and Perception (PR). It helps to understand trends, correlations, and institutional performance over time.
Purpose
The app facilitates data science-driven insights into the NIRF rankings, helping stakeholders explore state-wise distributions, top institutions, and metric correlations interactively through statistical summaries and visualizations.
Features
* Dynamic data preview and filtering by year and number of institutions.
* Lollipop charts to compare top-ranked institutions on score and rank.
* Histograms and summary statistics for each ranking metric, supporting thorough exploratory data analysis (EDA).
* State-wise bar charts showing the concentration of ranked institutions.
* Scatter plots with linear smoothing to analyse correlations between metrics.
* Multi-year trend analysis for overall scores and individual institute performance.
* Fully reproducible analysis using clean, local CSV datasets.
Data Source
Official NIRF ranking datasets from https://www.nirfindia.org/, cleaned and compiled from 2017 to 2025.
Installation and Usage
Prerequisites
* R version 4.0 or higher
* RStudio IDE
* R packages: shiny, ggplot2, dplyr, rvest

Steps to Run
1. Clone or download the project repository.
2. Place all yearly NIRF CSV files into the same folder as app.
3. Open app.R in RStudio.
4. Click "Run App" to launch the Shiny application.
Technical Details
* Developed using R Shiny framework for a reactive web experience.
* Data manipulation with dplyr.
* Visualization with ggplot2 for clear, publication-quality charts.
* Web scraping with the rvest for data cleaning 
