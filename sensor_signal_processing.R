# 웨어러블 센서 데이터 시계열 전처리 및 이동평균선(Rolling Mean) 분석
library(dplyr)
library(ggplot2)
library(zoo)

set.seed(42)
time_steps <- seq(0, 10, length.out = 1000)
sensor_x <- sin(2 * pi * 1.5 * time_steps) + rnorm(1000, mean = 0, sd = 0.5)

sensor_data <- data.frame(
  Time = time_steps,
  Acc_X = sensor_x
)

sensor_data <- sensor_data %>%
  mutate(
    Acc_X_Filtered = rollmean(Acc_X, k = 20, fill = NA, align = "center")
  )

ggplot(sensor_data, aes(x = Time)) +
  geom_line(aes(y = Acc_X, color = "Original Signal"), alpha = 0.4) +
  geom_line(aes(y = Acc_X_Filtered, color = "Filtered Signal"), linewidth = 1.2) +
  labs(
    title = "Wearable Sensor Signal Filtering (1D Time-Series)",
    subtitle = "Applying rolling mean to reduce noise in accelerometer data",
    x = "Time (seconds)",
    y = "Acceleration (g)",
    color = "Signal Type"
  ) +
  theme_minimal() +
  scale_color_manual(values = c("Original Signal" = "gray50", "Filtered Signal" = "blue"))