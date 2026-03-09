# 제조 공정 불량(Defect) 데이터 세트 상관관계 분석 및 탐색적 데이터 분석(EDA)
library(corrplot)
library(caret)


set.seed(123)
n_samples <- 500
temperature <- rnorm(n_samples, 70, 5)
pressure <- temperature * 0.5 + rnorm(n_samples, 30, 2)
vibration <- rnorm(n_samples, 10, 1)


defect_prob <- plogis(-15 + 0.15 * temperature + 0.1 * pressure)
defect_label <- rbinom(n_samples, 1, defect_prob)

manufacturing_data <- data.frame(
  Temperature = temperature,
  Pressure = pressure,
  Vibration = vibration,
  Defect = as.factor(defect_label)
)

num_features <- manufacturing_data[, c("Temperature", "Pressure", "Vibration")]
cor_matrix <- cor(num_features)

png("correlation_plot.png", width = 800, height = 600)
corrplot(cor_matrix, method = "color", type = "upper", 
         addCoef.col = "black", tl.col = "black", tl.srt = 45,
         title = "Feature Correlation Matrix in Defect Data",
         mar = c(0,0,2,0))
dev.off()

print("EDA Analysis Complete. Correlation plot saved as correlation_plot.png")