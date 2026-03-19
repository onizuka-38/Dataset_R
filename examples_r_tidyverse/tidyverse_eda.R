# tidyverse_eda.R
suppressPackageStartupMessages({
  library(tidyverse)
})

mtcars_tbl <- as_tibble(mtcars, rownames = "car")

cat("Rows:", nrow(mtcars_tbl), "\n")
cat("Cols:", ncol(mtcars_tbl), "\n\n")

summary_tbl <- mtcars_tbl %>%
  summarise(across(where(is.numeric), list(mean = mean, sd = sd), .names = "{.col}_{.fn}"))

cat("Numeric summary (mean/sd):\n")
print(summary_tbl)

p1 <- ggplot(mtcars_tbl, aes(x = mpg)) +
  geom_histogram(bins = 10, fill = "#2E86AB", color = "white") +
  labs(title = "MPG Distribution", x = "MPG", y = "Count") +
  theme_minimal(base_size = 12)

ggsave("examples_r_tidyverse/output_tidy_mtcars_hist.png", p1, width = 8, height = 5)

p2 <- ggplot(mtcars_tbl, aes(x = wt, y = mpg)) +
  geom_point(color = "#1B4965", size = 2) +
  geom_smooth(method = "lm", se = FALSE, color = "#E63946") +
  labs(title = "MPG vs Weight", x = "Weight", y = "MPG") +
  theme_minimal(base_size = 12)

ggsave("examples_r_tidyverse/output_tidy_mtcars_scatter.png", p2, width = 8, height = 5)

cat("\nSaved: output_tidy_mtcars_hist.png, output_tidy_mtcars_scatter.png\n")
