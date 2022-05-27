# clear work space and screen
rm(list=ls()) # clear data and value
shell("cls") # clear screen
gc() # clear memory


# packages for Long short term memory
library(keras)
library(dplyr)
library(ggplot2)
library(ggthemes)
library(lubridate)
library(readr)
library(ggplot2)


# set script path
current_path<-getwd()
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# read data from .txt document
HN_PM25 <- read_csv("./PM25.txt",col_names = TRUE,show_col_types = FALSE)
# View(CSJ_PM25) view data



# load function
source("./LSTM.R")



# Zhengzhou time series
ZZ_lag<-3
ZZ_seasonal_lag<-1
test_size<-24
set.seed(1)
ZZ=HN_PM25$ZZ
ZZ_fit<-LSTM(ZZ,ZZ_lag,ZZ_seasonal_lag,test_size)
ZZ.fit<-c(rep(NA,11+ZZ_seasonal_lag),ZZ_fit)
plot(ZZ.fit)


# Anyang time series
AY_lag<-3
AY_seasonal_lag<-1
test_size<-24
set.seed(1)
AY=HN_PM25$AY
AY_fit<-LSTM(AY,AY_lag,AY_seasonal_lag,test_size)
AY.fit<-c(rep(NA,11+AY_seasonal_lag),AY_fit)
plot(AY.fit)




# Xinxiang time series
XX_lag<-2
XX_seasonal_lag<-1
test_size<-24
set.seed(1)
XX=HN_PM25$XX
XX_fit<-LSTM(XX,XX_lag,XX_seasonal_lag,test_size)
XX.fit<-c(rep(NA,11+XX_seasonal_lag),XX_fit)
plot(XX.fit)



# Luoyang time series
LY_lag<-2
LY_seasonal_lag<-1
test_size<-24
set.seed(1)
LY=HN_PM25$LY
LY_fit<-LSTM(LY,LY_lag,LY_seasonal_lag,test_size)
LY.fit<-c(rep(NA,11+LY_seasonal_lag),LY_fit)
plot(LY.fit)



# Shangqiu time series
SQ_lag<-1
SQ_seasonal_lag<-1
test_size<-24
set.seed(1)
SQ=HN_PM25$SQ
SQ_fit<-LSTM(SQ,SQ_lag,SQ_seasonal_lag,test_size)
SQ.fit<-c(rep(NA,11+SQ_seasonal_lag),SQ_fit)
plot(SQ.fit)



# Nangyang time series
NY_lag<-1
NY_seasonal_lag<-1
test_size<-24
set.seed(1)
NY=HN_PM25$NY
NY_fit<-LSTM(NY,NY_lag,NY_seasonal_lag,test_size)
NY.fit<-c(rep(NA,11+NY_seasonal_lag),NY_fit)
plot(NY.fit)


# data export
HN_LSTM=data.frame(ZZ.fit,AY.fit,XX.fit,LY.fit,SQ.fit,NY.fit)
HN_LSTM
write.csv(HN_LSTM,"../benchmark_other_model_data/PM25_LSTM.csv")
setwd("../") #return to 
