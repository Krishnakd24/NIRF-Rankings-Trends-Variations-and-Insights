# 🎓 NIRF Rankings: Trends, Variations, and Insights

![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)
![Shiny](https://img.shields.io/badge/Shiny-316CE6?style=for-the-badge&logo=RStudio&logoColor=white)

An interactive, data-driven web application built with **R Shiny** to explore the National Institutional Ranking Framework (NIRF) data in India from **2017 to 2025**. 

---

## Why This Project?

The NIRF framework ranks higher education institutions in India based on diverse parameters like Teaching, Learning & Resources (TLR), Research & Professional Practice (RPC), Graduation Outcomes (GO), Outreach & Inclusivity (OI), and Perception (PR).

This dashboard was created to:
* **Make data accessible**: Transform thousands of rows of tabular data into engaging, interactive visual insights.
* **Identify trends**: Track how the performance of Indian educational institutions fluctuates or grows over time.
* **Democratize education insights**: Give students, researchers, and policymakers an easy tool to make data-informed analyses of higher education quality.
* **Examine metric correlation**: Understand what metrics influence the overall ranking the most (e.g., does Perception highly correlate with Research & Professional Practice?).

---

## Features

* **Single Year Analysis**: Pick any year between 2017 and 2025 to dive deep into that specific dataset.
  * **Interactive EDA (Exploratory Data Analysis)**: View histograms and summary statistics for every sub-metric (TLR, RPC, GO, OI, PR).
  * **Lollipop Charts**: Engaging visual comparisons of the top institutions by overall score.
  * **State-wise Distribution**: Understand the geographic concentration of top-ranked colleges across India using bar charts.
  * **Custom Scatter Plots**: Select any two variables to plot and analyze their linear correlation dynamically.
* **Multi-Year Trends**:
  * Track the **Average Overall Score** of the Top 10, Top 50, or Top 100 colleges across all recorded years.
  * View an individual institute's trajectory with **Institute-wise Score Variation**, observing exactly how their performance jumped or dipped year over year.

---

## How to Run Locally

You can easily run this application on your local machine using R and RStudio.

### 1. Prerequisites

Make sure you have R (>= 4.0.0) installed alongside the following packages:
```r
install.packages(c("shiny", "ggplot2", "dplyr", "rvest"))
```

### 2. Download and Run

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/NIRF-Rankings-Trends-Variations-and-Insights.git
   cd NIRF-Rankings-Trends-Variations-and-Insights
   ```

2. **Run the App:**
   Open `app.R` in **RStudio** and click on the **Run App** button, or execute it through your R console:
   ```r
   shiny::runApp()
   ```
   
> **Note on Data**: All historical datasets (.csv format) are neatly organized inside the `CSVs/` directory. The application is pre-configured to read from this directory automatically, meaning it works right out of the box!

---

## Tech Stack

* **Front-end & Server**: [R Shiny](https://shiny.rstudio.com/) for reactive web layouts and dynamic logic.
* **Data Processing**: [dplyr](https://dplyr.tidyverse.org/) for rapid data manipulation, cleaning, and summarisation.
* **Data Visualization**: [ggplot2](https://ggplot2.tidyverse.org/) for beautiful, customizable, and publication-ready charting.
* **Data Preprocessing**: [rvest](https://rvest.tidyverse.org/) was utilized for initial web scraping to compile this local historical dataset.

---

## Acknowledgements

**Data Source**: All datasets were sourced and cleaned from the official National Institutional Ranking Framework platform at [nirfindia.org](https://www.nirfindia.org/).
