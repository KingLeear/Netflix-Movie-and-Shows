# install.packages('readr')
# install.packages('tidytext')
# install.packages('stringr')
# install.packages('shiny')
# install.packages('dplyr')
# install.packages("rvest")
# install.packages("httr")
# install.packages("bslib")
install.packages("lubridate")
library(readr)
library(tidytext)
library(stringr)
library(shiny)
library(dplyr)
library(bslib)
library(stringr)
library(leaflet)
library(rvest)
library(httr)


#data import
movies <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-29/movies.csv')
shows <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-29/shows.csv')
print(movies)

# Q1: What is the relation between time since release and current viewing performance? Do older shows have staying power or do newer releases dominate?
library(lubridate)
shows$release_date <- as.Date(shows$release_date)
shows$age_days <- as.numeric(Sys.Date() - shows$release_date)
shows$age_years <- shows$age_days / 365

plot(shows$age_years, shows$views,
     xlab = "Years since release",
     ylab = "Current views",
     main = "Show Age vs. Current Views")

shows$age_group <- cut(shows$age_years,
                       breaks = c(0,1,3,5,10,Inf),
                       labels = c("<1yr","1–3yr","3–5yr","5–10yr","10+yr"))
aggregate(views ~ age_group, data = shows, mean)

model <- lm(log1p(views) ~ age_years + runtime + available_globally, data = shows)
summary(model)

# Q2: How does the timing of a show's release (month/season) relate to engagement metrics?
shows$month <- as.numeric(format(shows$release_date, "%m"))

shows$release_season <- cut(shows$month,
                            breaks = c(0,3,6,9,12),
                            labels = c("Winter","Spring","Summer","Autumn"))

shows$release_month <- as.numeric(format(shows$release_date, "%m"))

## Performance metrics
shows$avg_hours_per_viewer <- shows$hours_viewed / shows$views

shows_clean <- shows %>% 
  filter(!is.na(release_month), !is.na(avg_hours_per_viewer))

model_month <- lm(avg_hours_per_viewer ~ as.factor(release_month), data = shows_clean)
summary(model_month)


monthly <- shows %>%
  group_by(release_month) %>%
  summarise(avg_hours = mean(avg_hours_per_viewer, na.rm = TRUE))

ggplot(shows_clean, aes(x = as.factor(release_month), y = avg_hours_per_viewer)) +
  geom_boxplot(fill = "lightblue", alpha = 0.6) +
  stat_summary(fun = mean, geom = "point", shape = 20, size = 4, color = "red") +
  labs(
    title = "Release Month vs. Viewer Engagement",
    x = "Release Month",
    y = "Avg Hours per Viewer"
  ) +
  theme_minimal()


ggplot(monthly, aes(x = release_month, y = avg_hours)) +
  geom_point(size = 3, color = "blue") +
  geom_line(color = "blue", alpha = 0.6) +
  geom_smooth(method = "lm", se = TRUE, color = "red", linetype = "dashed") +
  scale_x_continuous(breaks = 1:12, labels = month.abb) +
  labs(
    title = "Monthly Release vs. Engagement (with Trend Line)",
    x = "Release Month",
    y = "Avg Hours per Viewer"
  ) +
  theme_minimal()

shows_clean <- shows[!is.na(shows$release_season), ]



model_season <- lm(avg_hours_per_viewer ~ as.factor(release_season), data = shows_clean)
summary(model_season)
library(ggplot2)

ggplot(shows_clean, aes(x = release_season, y = avg_hours_per_viewer)) +
  geom_boxplot(outlier.shape = NA, fill = "lightgreen") +
  stat_summary(fun = mean, geom = "line", aes(group=1), color="red", linewidth=1) +
  labs(
    title = "Release Season vs Viewer Engagement",
    x = "Release Season",
    y = "Avg Hours per Viewer"
  )





