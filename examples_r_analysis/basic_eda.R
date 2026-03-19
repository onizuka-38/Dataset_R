# basic_eda.R
# Basic exploratory data analysis with mtcars

data(mtcars)

cat("Rows:", nrow(mtcars), "\n")
cat("Cols:", ncol(mtcars), "\n\n")

cat("Summary statistics:\n")
print(summary(mtcars))

# Correlation matrix (numeric columns)
cat("\nCorrelation matrix:\n")
print(round(cor(mtcars), 2))

# Simple plots
png("examples_r_analysis/output_mtcars_hist.png", width = 900, height = 600)
hist(mtcars$mpg, breaks = 10, main = "MPG Distribution", xlab = "mpg", col = "skyblue")
dev.off()

png("examples_r_analysis/output_mtcars_scatter.png", width = 900, height = 600)
plot(mtcars$wt, mtcars$mpg,
     main = "MPG vs Weight",
     xlab = "Weight",
     ylab = "MPG",
     pch = 19,
     col = "darkblue")
abline(lm(mpg ~ wt, data = mtcars), col = "red", lwd = 2)
dev.off()

cat("\nSaved: output_mtcars_hist.png, output_mtcars_scatter.png\n")
