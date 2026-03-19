# linear_regression_example.R
# Train/test split + linear regression on mtcars

set.seed(42)
data(mtcars)

idx <- sample(seq_len(nrow(mtcars)), size = floor(0.8 * nrow(mtcars)))
train <- mtcars[idx, ]
test <- mtcars[-idx, ]

model <- lm(mpg ~ wt + hp + cyl, data = train)
cat("Model summary:\n")
print(summary(model))

pred <- predict(model, newdata = test)
actual <- test$mpg

rmse <- sqrt(mean((pred - actual)^2))
mae <- mean(abs(pred - actual))

cat("\nEvaluation on test set:\n")
cat("RMSE:", round(rmse, 3), "\n")
cat("MAE :", round(mae, 3), "\n")

result <- data.frame(actual = actual, predicted = round(pred, 2))
cat("\nPredictions:\n")
print(result)
