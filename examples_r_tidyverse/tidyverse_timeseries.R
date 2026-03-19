# tidyverse_timeseries.R
suppressPackageStartupMessages({
  library(tidyverse)
})

ts_data <- AirPassengers

ts_tbl <- tibble(
  time = as.numeric(time(ts_data)),
  passengers = as.numeric(ts_data)
)

cat("Rows:", nrow(ts_tbl), "\n")
cat("From:", min(ts_tbl$time), "To:", max(ts_tbl$time), "\n\n")

decomp <- decompose(ts_data, type = "multiplicative")
trend_tbl <- tibble(
  time = as.numeric(time(ts_data)),
  trend = as.numeric(decomp$trend)
)

last_12 <- tail(ts_tbl$passengers, 12)
forecast_tbl <- tibble(
  time = seq(max(ts_tbl$time) + 1/12, max(ts_tbl$time) + 1, by = 1/12),
  passengers = last_12,
  series = "Forecast"
)

history_tbl <- ts_tbl %>% mutate(series = "History")
plot_tbl <- bind_rows(history_tbl, forecast_tbl)

p <- ggplot(plot_tbl, aes(x = time, y = passengers, color = series)) +
  geom_line(linewidth = 1) +
  scale_color_manual(values = c("History" = "#1D3557", "Forecast" = "#E63946")) +
  labs(title = "AirPassengers: History + Naive Forecast", x = "Year", y = "Passengers") +
  theme_minimal(base_size = 12)

ggsave("examples_r_tidyverse/output_tidy_airpassengers_forecast.png", p, width = 9, height = 5)

p_trend <- ggplot(trend_tbl, aes(x = time, y = trend)) +
  geom_line(color = "#457B9D", linewidth = 1) +
  labs(title = "AirPassengers Trend (Decomposition)", x = "Year", y = "Trend") +
  theme_minimal(base_size = 12)

ggsave("examples_r_tidyverse/output_tidy_airpassengers_trend.png", p_trend, width = 9, height = 5)

cat("Saved: output_tidy_airpassengers_forecast.png, output_tidy_airpassengers_trend.png\n")
