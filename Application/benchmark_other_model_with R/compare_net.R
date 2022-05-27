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


# establish neural net
set.seed(20)
# training 
# auto order
ZZ_net <- nnetar(ZZ_fit,size = 3,lambda="auto")
ZZ_net
ZZ_net_fit <- forecast(ZZ_net)
ZZ_AEF<-abs(ZZ_net$residuals)
ZZ_MAEF<-mean(ZZ_AEF,na.rm = TRUE)
# testing 
ZZ_net_fore <- forecast(ZZ_net_fit, h = test)
# mean percentage error
ZZ_APET<-abs(ZZ_net_fore$mean-ZZ_test)
ZZ_MAPET<-mean(ZZ_APET,na.rm = TRUE)
plot(ZZ_net_fore)
ZZ.fit<-c(ZZ_net_fit$fitted,ZZ_net_fore$mean)
ZZ.fit


# Anyang time series
AY=HN_PM25$AY
AY_ts=ts(AY, frequency = 12, start = c(2015, 1))
AY_fit=ts(AY[1:train], frequency = 12, start = c(2015, 1)) # 2015
AY_test=ts(AY[train+1:l], frequency = 12, start = c(2020, 1)) # 2020



# establish neural net
set.seed(20)
# training 
# auto order
AY_net <- nnetar(AY_fit,size = 3,lambda="auto")
AY_net
AY_net_fit <- forecast(AY_net)
AY_AEF<-abs(AY_net$residuals)
AY_MAEF<-mean(AY_AEF,na.rm = TRUE)
# testing 
AY_net_fore <- forecast(AY_net_fit, h = test)
# mean percentage error
AY_APET<-abs(AY_net_fore$mean-AY_test)
AY_MAPET<-mean(AY_APET,na.rm = TRUE)
plot(AY_net_fore)
AY.fit<-c(AY_net_fit$fitted,AY_net_fore$mean)
AY.fit


# Xinxiang time series
XX=HN_PM25$XX
XX_ts=ts(XX, frequency = 12, start = c(2015, 1))
XX_fit=ts(XX[1:train], frequency = 12, start = c(2015, 1)) # 2015
XX_test=ts(XX[train+1:l], frequency = 12, start = c(2020, 1)) # 2020


# establish neural net
set.seed(20)
# training 
# auto order
XX_net <- nnetar(XX_fit,size = 3,lambda="auto")
XX_net
XX_net_fit <- forecast(XX_net)
XX_AEF<-abs(XX_net$residuals)
XX_MAEF<-mean(XX_AEF,na.rm = TRUE)
# testing 
XX_net_fore <- forecast(XX_net_fit, h = test)
# mean percentage error
XX_APET<-abs(XX_net_fore$mean-XX_test)
XX_MAPET<-mean(XX_APET,na.rm = TRUE)
plot(XX_net_fore)
XX.fit<-c(XX_net_fit$fitted,XX_net_fore$mean)
XX.fit


# Luoyang time series
LY=HN_PM25$LY
LY_ts=ts(LY, frequency = 12, start = c(2015, 1))
LY_fit=ts(LY[1:train], frequency = 12, start = c(2015, 1)) # 2015
LY_test=ts(LY[train+1:l], frequency = 12, start = c(2020, 1)) # 2020


# establish neural net
set.seed(20)
# training 
# auto order
LY_net <- nnetar(LY_fit,size = 3,lambda="auto")
LY_net
LY_net_fit <- forecast(LY_net)
LY_AEF<-abs(LY_net$residuals)
LY_MAEF<-mean(LY_AEF,na.rm = TRUE)
# testing 
LY_net_fore <- forecast(LY_net_fit, h = test)
# mean percentage error
LY_APET<-abs(LY_net_fore$mean-LY_test)
LY_MAPET<-mean(LY_APET,na.rm = TRUE)
plot(LY_net_fore)
LY.fit<-c(LY_net_fit$fitted,LY_net_fore$mean)
LY.fit


# Shangqiu time series
SQ=HN_PM25$SQ
SQ_ts=ts(SQ, frequency = 12, start = c(2015, 1))
SQ_fit=ts(SQ[1:train], frequency = 12, start = c(2015, 1)) # 2015
SQ_test=ts(SQ[train+1:l], frequency = 12, start = c(2020, 1)) # 2020


# establish neural net
set.seed(20)
# training 
# auto order
SQ_net <- nnetar(SQ_fit,size = 3,lambda="auto")
SQ_net
SQ_net_fit <- forecast(SQ_net)
SQ_AEF<-abs(SQ_net$residuals)
SQ_MAEF<-mean(SQ_AEF,na.rm = TRUE)
# testing 
SQ_net_fore <- forecast(SQ_net_fit, h = test)
# mean percentage error
SQ_APET<-abs(SQ_net_fore$mean-SQ_test)
SQ_MAPET<-mean(SQ_APET,na.rm = TRUE)
plot(SQ_net_fore)
SQ.fit<-c(SQ_net_fit$fitted,SQ_net_fore$mean)
SQ.fit


# Nanyang time series
NY=HN_PM25$NY
NY_ts=ts(NY, frequency = 12, start = c(2015, 1))
NY_fit=ts(NY[1:train], frequency = 12, start = c(2015, 1)) # 2015
NY_test=ts(NY[train+1:l], frequency = 12, start = c(2020, 1)) # 2020


# establish neural net
set.seed(0)
# training 
# auto order
NY_net <- nnetar(NY_fit,size = 3,lambda="auto")
NY_net
NY_net_fit <- forecast(NY_net)
NY_AEF<-abs(NY_net$residuals)
NY_MAEF<-mean(NY_AEF,na.rm = TRUE)
# testing 
NY_net_fore <- forecast(NY_net_fit, h = test)
# mean percentage error
NY_APET<-abs(NY_net_fore$mean-NY_test)
NY_MAPET<-mean(NY_APET,na.rm = TRUE)
plot(NY_net_fore)
NY.fit<-c(NY_net_fit$fitted,NY_net_fore$mean)
NY.fit



# data export
HN_Net=data.frame(ZZ.fit,AY.fit,XX.fit,LY.fit,SQ.fit,NY.fit)
HN_Net
write.csv(HN_Net,"../benchmark_other_model_data/PM25_Net.csv")

setwd("../") #return to 

