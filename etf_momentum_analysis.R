# QQQ(나스닥 100) 및 SPY(S&P 500) ETF 주가 데이터 수집 및 이동평균선 시각화
# 설치 필요: install.packages("quantmod") 패키지
library(quantmod)


tickers <- c("QQQ", "SPY")
getSymbols(tickers, src = "yahoo", from = Sys.Date() - 365, to = Sys.Date())

qqq_data <- Cl(QQQ) # 종가(Close) 데이터 추출
qqq_sma50 <- SMA(qqq_data, n = 50)
qqq_sma200 <- SMA(qqq_data, n = 200)

chartSeries(QQQ, 
            type = "line", 
            theme = chartTheme("white", up.col='red', dn.col='blue'),
            name = "Invesco QQQ Trust (Nasdaq 100) - Momentum Analysis",
            TA = c(addSMA(n = 50, col = "blue"), addSMA(n = 200, col = "red")))

legend("topright", legend = c("50-Day SMA", "200-Day SMA"), 
       col = c("blue", "red"), lty = 1, cex = 0.8)