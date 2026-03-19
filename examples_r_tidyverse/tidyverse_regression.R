# tidyverse_regression.R
suppressPackageStartupMessages({
  library(tidyverse)
})

set.seed(42)
mtcars_tbl <- as_tibble(mtcars)

idx <- sample(seq_len(nrow(mtcars_tbl)), size = floor(0.8 * nrow(mtcars_tbl)))
train <- mtcars_tbl[idx, ]
test <- mtcars_tbl[-idx, ]

model <- lm(mpg ~ wt + hp + cyl, data = train)
cat("Model coefficients:\n")
print(coef(summary(model)))

pred <- predict(model, newdata = test)

metrics <- tibble(
  rmse = sqrt(mean((pred - test$mpg)^2)),
  mae = mean(abs(pred - test$mpg))
)

cat("\nTest metrics:\n")
print(metrics)

pred_tbl <- test %>%
  transmute(actual = mpg, predicted = round(pred, 2))

cat("\nPredictions:\n")
print(pred_tbl)
