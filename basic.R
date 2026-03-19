# =========================
# 1. 기초 EDA 예제
# =========================

# 내장 데이터셋 사용
df <- mtcars

# 데이터 앞부분 확인
head(df)

# 구조 확인
str(df)

# 요약 통계
summary(df)

# 행/열 크기 확인
dim(df)

# 컬럼명 확인
names(df)

# 결측치 개수 확인
colSums(is.na(df))

# 숫자형 컬럼만 선택
numeric_cols <- sapply(df, is.numeric)
df_numeric <- df[, numeric_cols]

# 각 컬럼 평균
colMeans(df_numeric)

# 각 컬럼 표준편차
apply(df_numeric, 2, sd)