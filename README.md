# 📺 TidyTuesday 2025-07-29 — Netflix Movies & Shows

This repository contains my contribution to the [TidyTuesday](https://github.com/rfordatascience/tidytuesday) project for the week of **2025-07-29**, focusing on **Netflix Movies and Shows**.  
The project mainly explores how release timing and availability relate to audience engagement.

---

## 🔍 Research Questions

The analysis is guided by several core questions:

1. **Viewing Sustainability**
   - Do older shows maintain viewing performance, or do newer releases dominate?  
   - How should “old” be defined (e.g., > 2 years since release)?  
   - Can “sustainability” be measured by the slope of viewership decline?

2. **Release Timing**
   - How does the timing of a show's release (month/season) relate to engagement metrics?  
   - Which engagement metrics matter most (hours viewed, total views, runtime-adjusted views)?

3. **Global vs. Regional Availability**
   - How does the performance of globally available titles compare to regionally restricted ones?  
   - Does “better performance” mean higher viewership, longer watch hours, or other forms of engagement?

4. **Top Performers Across Reports**
   - How do the top movie performers in each reporting period compare?  
   - Are the same kinds of movies consistently popular?

5. **Series Continuity**
   - Do later seasons of popular shows gain, lose, or maintain engagement compared to earlier seasons?  
   - What patterns emerge across multiple engagement reports?

---

## 📊 Dataset

- **Source**: [TidyTuesday 2025-07-29 — Netflix data](https://github.com/rfordatascience/tidytuesday/blob/main/data/2025/2025-07-29/readme.md)  
- **Columns**:  
  - Title, Release date, Hours viewed, Runtime, Global availability, etc.  
- Despite having relatively few columns, the dataset can be transformed and recoded into meaningful derived variables for deeper insights.

---

## 🛠 Methods

- Data wrangling with **tidyverse**  
- Exploratory analysis and visualization in **ggplot2**  
- Feature engineering (e.g., defining sustainability, categorizing release timing)  
- Regression and trend analysis to test hypotheses

---

## 🚧 Notes

- This project is currently code-only due to time constraints.  
- Textual write-ups and interpretation will be updated later.  
- Even with limited variables, the dataset allows creative exploration and reframing of engagement dynamics.

---
## Some findings(Descriptive Analysis)
### 1. Overall Model Performance
- The regression model is statistically significant, but explains only **~26–31% of the variance** in viewership (R² = 0.31, Adjusted R² = 0.27).  
- The residual standard error is about **1 unit (on log(views))**, indicating moderate prediction accuracy.  
- Roughly half of the original data was excluded due to missingness (12,828 valid observations out of 26,962).  

👉 **Interpretation**: The model captures some meaningful patterns, but the majority of variation in viewing behavior remains unexplained, suggesting other factors are at play.

---

### 2. Release Month and Engagement
Engagement was defined as:  

\[
\text{Engagement} = \frac{\text{hours\_viewed}}{\text{views}}
\]

This represents the **average hours watched per viewer**.

- **Explanatory power is negligible**: R² = 0.0028. Month explains less than 1% of the variation in engagement.  
- **Statistical significance vs. practical significance**: With a large sample, small differences across months become significant, but the effect size is extremely small.  
- **Month-specific effects**:  
  - June: +0.80 hours (p < 0.001)  
  - August: +0.69 hours (p = 0.003)  
  - July: +0.49 hours (p = 0.036)  
  - December: +0.52 hours (p = 0.020)  

👉 **Interpretation**: While June, August, July, and December releases show slightly higher engagement, the overall impact of release month is minimal. This pattern may reflect seasonal viewing habits (summer holidays, year-end breaks), but release timing is **not a major driver of engagement**.
