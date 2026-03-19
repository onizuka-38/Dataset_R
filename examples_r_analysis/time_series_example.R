# time_series_example.R
# Time-series decomposition + simple forecast using AirPassengers

ts_data <- AirPassengers

cat("Time series summary:\n")
print(summary(ts_data))

decomp <- decompose(ts_data, type = "multiplicative")

png("examples_r_analysis/output_airpassengers_decompose.png", width = 1000, height = 700)
plot(decomp)
dev.off()

# naive forecast: use previous 12 months as next 12 months
last_12 <- tail(ts_data, 12)
forecast_12 <- ts(last_12,
                  start = c(1961, 1),
                  frequency = 12)

cat("\nNaive 12-month forecast:\n")
print(forecast_12)

png("examples_r_analysis/output_airpassengers_forecast.png", width = 1000, height = 700)
plot(ts_data, xlim = c(1949, 1961), ylim = c(min(ts_data), max(c(ts_data, forecast_12))),
     main = "AirPassengers: History + Naive Forecast", ylab = "Passengers")
lines(forecast_12, col = "red", lwd = 2)
legend("topleft", legend = c("History", "Naive forecast"), col = c("black", "red"), lty = 1, bty = "n")
dev.off()

cat("\nSaved: output_airpassengers_decompose.png, output_airpassengers_forecast.png\n")
