# clear work space and screen
rm(list=ls()) # clear data and value
shell("cls") # clear screen
gc() # clear memory

# load package
library(forecast) # packages for Holt-Winter
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


# Zhengzhou holt-winter model
ZZ_hw<-ets(ZZ_fit)
ZZ_AEF=abs(ZZ_hw$residuals)
ZZ_MAEF=mean(ZZ_AEF)
ZZ_pre<-forecast(ZZ_hw,test)
ZZ_AET=abs(ZZ_pre$mean-ZZ_test)
ZZ_MAET=mean(ZZ_AET)
plot(ZZ_pre)
ZZ.fit=c(ZZ_hw$fitted,ZZ_pre$mean)


# Anyang time series
AY=HN_PM25$AY
AY_ts=ts(AY, frequency = 12, start = c(2015, 1))
AY_fit=ts(AY[1:train], frequency = 12, start = c(2015, 1)) # 2015
AY_test=ts(AY[train+1:l], frequency = 12, start = c(2020, 1)) # 2020


# Anyang holt-winter model
AY_hw<-ets(AY_fit)
AY_AEF=abs(AY_hw$residuals)
AY_MAEF=mean(AY_AEF)
AY_pre<-forecast(AY_hw,test)
AY_APET=abs(AY_pre$mean-AY_test)
AY_MAPET=mean(AY_APET)
plot(AY_pre)
AY.fit=c(AY_hw$fitted,AY_pre$mean)


# Xinxiang time series
XX=HN_PM25$XX
XX_ts=ts(XX, frequency = 12, start = c(2015, 1))
XX_fit=ts(XX[1:train], frequency = 12, start = c(2015, 1)) # 2015
XX_test=ts(XX[train+1:l], frequency = 12, start = c(2020, 1)) # 2020



# Xinxiang holt-winter model
XX_hw<-ets(XX_fit)
XX_AEF=abs(XX_hw$residuals)
XX_MAEF=mean(XX_AEF)
XX_pre<-forecast(XX_hw,test)
XX_APET=abs(XX_pre$mean-XX_test)
XX_MAPET=mean(XX_APET)
plot(XX_pre)
XX.fit=c(XX_hw$fitted,XX_pre$mean)


# Luoyang time series
LY=HN_PM25$LY
LY_ts=ts(LY, frequency = 12, start = c(2015, 1))
LY_fit=ts(LY[1:train], frequency = 12, start = c(2015, 1)) # 2015
LY_test=ts(LY[train+1:l], frequency = 12, start = c(2020, 1)) # 2020



# Luoyang holt-winter model
LY_hw<-ets(LY_fit)
LY_AEF=abs(LY_hw$residuals)
LY_MAEF=mean(LY_AEF)
LY_pre<-forecast(LY_hw,test)
LY_APET=abs(LY_pre$mean-LY_test)
LY_MAPET=mean(LY_APET)
plot(LY_pre)
LY.fit=c(LY_hw$fitted,LY_pre$mean)


# Shangqiu time series
SQ=HN_PM25$SQ
SQ_ts=ts(SQ, frequency = 12, start = c(2015, 1))
SQ_fit=ts(SQ[1:train], frequency = 12, start = c(2015, 1)) # 2015
SQ_test=ts(SQ[train+1:l], frequency = 12, start = c(2020, 1)) # 2020



# Shangqiu holt-winter model
SQ_hw<-ets(SQ_fit)
SQ_AEF=abs(SQ_hw$residuals)
SQ_MAEF=mean(SQ_AEF)
SQ_pre<-forecast(SQ_hw,test)
SQ_APET=abs(SQ_pre$mean-SQ_test)
SQ_MAPET=mean(SQ_APET)
plot(SQ_pre)
SQ.fit=c(SQ_hw$fitted,SQ_pre$mean)


# Nanyang time series
NY=HN_PM25$NY
NY_ts=ts(NY, frequency = 12, start = c(2015, 1))
NY_fit=ts(NY[1:train], frequency = 12, start = c(2015, 1)) # 2015
NY_test=ts(NY[train+1:l], frequency = 12, start = c(2020, 1)) # 2020



# Nanyang holt-winter model
NY_hw<-ets(NY_fit)
NY_AEF=abs(NY_hw$residuals)
NY_MAEF=mean(NY_AEF)
NY_pre<-forecast(NY_hw,test)
NY_APET=abs(NY_pre$mean-NY_test)
NY_MAPET=mean(NY_APET)
plot(NY_pre)
NY.fit=c(NY_hw$fitted,NY_pre$mean)



# data export
HN_hw=data.frame(ZZ.fit,AY.fit,XX.fit,LY.fit,SQ.fit,NY.fit)
HN_hw
write.csv(HN_hw,"../benchmark_other_model_data/PM25_HW.csv")


# return to current_path
setwd(current_path) 
