# tidyverse_classification.R
suppressPackageStartupMessages({
  library(tidyverse)
})

iris_tbl <- as_tibble(iris) %>%
  mutate(target = if_else(Species == "setosa", 1, 0))

set.seed(123)
idx <- sample(seq_len(nrow(iris_tbl)), size = floor(0.75 * nrow(iris_tbl)))
train <- iris_tbl[idx, ]
test <- iris_tbl[-idx, ]

clf <- glm(target ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width,
           data = train,
           family = binomial())

proba <- predict(clf, newdata = test, type = "response")
pred <- if_else(proba >= 0.5, 1, 0)

acc <- mean(pred == test$target)
cat("Accuracy:", round(acc, 4), "\n\n")

cm <- tibble(Predicted = pred, Actual = test$target) %>%
  count(Predicted, Actual)

cat("Confusion matrix (count):\n")
print(cm)
