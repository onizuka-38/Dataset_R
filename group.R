df <- mtcars

# cyl을 범주형으로 변환
df$cyl <- as.factor(df$cyl)

# 그룹별 평균 연비
aggregate(mpg ~ cyl, data = df, FUN = mean)

# 그룹별 평균 마력(hp)
aggregate(hp ~ cyl, data = df, FUN = mean)

# 그룹별 개수
table(df$cyl)

# 그룹별 여러 통계량 계산
aggregate(cbind(mpg, hp, wt) ~ cyl, data = df, 
          FUN = function(x) c(mean = mean(x), sd = sd(x)))