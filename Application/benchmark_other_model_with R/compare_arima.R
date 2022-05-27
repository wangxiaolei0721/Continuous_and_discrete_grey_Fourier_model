# clear work space and screen
rm(list=ls()) # clear data and value
shell("cls") # clear screen
gc() # clear memory


# load package
library(forecast) # packages for ARIMA
library(readr)
library(ggplot2)


# set script path
current_path<-getwd()
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


#read data
HN_PM25 <- read_csv("./PM25.txt",col_types = cols())
# View(HN_PM25) view data


# train and test
l<-nrow(HN_PM25);
test<-24
train<-l-test


# Zhengzhou time series
ZZ=HN_PM25$ZZ
ZZ_ts=ts(ZZ, frequency = 12, start = c(2015, 1))
ZZ_fit=ts(ZZ[1:train], frequency = 12, start = c(2015, 1)) # 2015
ZZ_test=ts(ZZ[train+1:l], frequency = 12, start = c(2020, 1)) # 2020


# Zhengzhou SARIMA model
ZZ_arima = auto.arima(ZZ_fit)
ZZ_arima
ZZ_AEF=abs(ZZ_arima$residuals)
ZZ_MAEF=mean(ZZ_AEF)
ZZ_arima_fore = forecast(ZZ_arima, h = test)
ZZ_arima_fore
ZZ_AET=abs(ZZ_arima_fore$mean-ZZ_test)
ZZ_MAET=mean(ZZ_AET)
plot(ZZ_arima_fore)
ZZ.fit=c(ZZ_arima$fitted,ZZ_arima_fore$mean)



# Anyang time series
AY=HN_PM25$AY
AY_ts=ts(AY, frequency = 12, start = c(2015, 1))
AY_fit=ts(AY[1:train], frequency = 12, start = c(2015, 1)) # 2015
AY_test=ts(AY[train+1:l], frequency = 12, start = c(2020, 1)) # 2020

# Anyang SARIMA model
AY_arima = auto.arima(AY_fit)
AY_arima
AY_AEF=abs(AY_arima$residuals)
AY_MAEF=mean(AY_AEF)
AY_arima_fore = forecast(AY_arima, h = test)
AY_arima_fore
AY_AET=abs(AY_arima_fore$mean-AY_test)
AY_MAET=mean(AY_AET)
plot(AY_arima_fore)
AY.fit=c(AY_arima$fitted,AY_arima_fore$mean)



# Xinxiang time series
XX=HN_PM25$XX
XX_ts=ts(XX, frequency = 12, start = c(2015, 1))
XX_fit=ts(XX[1:train], frequency = 12, start = c(2015, 1)) # 2015
XX_test=ts(XX[train+1:l], frequency = 12, start = c(2020, 1)) # 2020

# Xinxiang SARIMA model
XX_arima = auto.arima(XX_fit)
XX_arima
XX_AEF=abs(XX_arima$residuals)
XX_MAEF=mean(XX_AEF)
XX_arima_fore = forecast(XX_arima, h = test)
XX_arima_fore
XX_AET=abs(XX_arima_fore$mean-XX_test)
XX_MAET=mean(XX_AET)
plot(XX_arima_fore)
XX.fit=c(XX_arima$fitted,XX_arima_fore$mean)



# Luoyang time series
LY=HN_PM25$LY
LY_ts=ts(LY, frequency = 12, start = c(2015, 1))
LY_fit=ts(LY[1:train], frequency = 12, start = c(2015, 1)) # 2015
LY_test=ts(LY[train+1:l], frequency = 12, start = c(2020, 1)) # 2020

# Luoyang SARIMA model
LY_arima = auto.arima(LY_fit)
LY_arima
LY_AEF=abs(LY_arima$residuals)
LY_MAEF=mean(LY_AEF)
LY_arima_fore = forecast(LY_arima, h = test)
LY_arima_fore
LY_AET=abs(LY_arima_fore$mean-LY_test)
LY_MAET=mean(LY_AET)
plot(LY_arima_fore)
LY.fit=c(LY_arima$fitted,LY_arima_fore$mean)



# Shangqiu time series
SQ=HN_PM25$SQ
SQ_ts=ts(SQ, frequency = 12, start = c(2015, 1))
SQ_fit=ts(SQ[1:train], frequency = 12, start = c(2015, 1)) # 2015
SQ_test=ts(SQ[train+1:l], frequency = 12, start = c(2020, 1)) # 2020

# Shangqiu SARIMA model
SQ_arima = auto.arima(SQ_fit)
SQ_arima
SQ_AEF=abs(SQ_arima$residuals)
SQ_MAEF=mean(SQ_AEF)
SQ_arima_fore = forecast(SQ_arima, h = test)
SQ_arima_fore
SQ_AET=abs(SQ_arima_fore$mean-SQ_test)
SQ_MAET=mean(SQ_AET)
plot(SQ_arima_fore)
SQ.fit=c(SQ_arima$fitted,SQ_arima_fore$mean)



# Nanyang time series
NY=HN_PM25$NY
NY_ts=ts(NY, frequency = 12, start = c(2015, 1))
NY_fit=ts(NY[1:train], frequency = 12, start = c(2015, 1)) # 2015
NY_test=ts(NY[train+1:l], frequency = 12, start = c(2020, 1)) # 2020


# Nangyang SARIMA model
NY_arima = auto.arima(NY_fit)
NY_arima
NY_AEF=abs(NY_arima$residuals)
NY_MAEF=mean(NY_AEF)
NY_arima_fore = forecast(NY_arima, h = test)
NY_arima_fore
NY_AET=abs(NY_arima_fore$mean-NY_test)
NY_MAET=mean(NY_AET)
plot(NY_arima_fore)
NY.fit=c(NY_arima$fitted,NY_arima_fore$mean)


# data export
HN_ARIMA=data.frame(ZZ.fit,AY.fit,XX.fit,LY.fit,SQ.fit,NY.fit)
HN_ARIMA
write.csv(HN_ARIMA,"../benchmark_other_model_data/PM25_ARIMA.csv")

setwd("../") #return to 

