# classification_example.R
# Binary classification using iris (setosa vs non-setosa)

data(iris)
iris$target <- ifelse(iris$Species == "setosa", 1, 0)

set.seed(123)
idx <- sample(seq_len(nrow(iris)), size = floor(0.75 * nrow(iris)))
train <- iris[idx, ]
test <- iris[-idx, ]

clf <- glm(target ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width,
           data = train,
           family = binomial())

proba <- predict(clf, newdata = test, type = "response")
pred <- ifelse(proba >= 0.5, 1, 0)

acc <- mean(pred == test$target)

cat("Classification accuracy:", round(acc, 4), "\n\n")
cat("Confusion matrix:\n")
print(table(Predicted = pred, Actual = test$target))
