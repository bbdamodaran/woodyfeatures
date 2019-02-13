## Random forest classifier demo
rm(list=ls())
pstrttime<-Sys.time()
old_dir<-setwd("D:/PostDocWork/SIRS_WoodyFeatures/Rcodes")
getwd()
source('bh_loadLib.R')
bh_loadLib()

## Load matlab data
fname<-"D:/PostDocWork/HSIC-CV/Pavia_Univ_Train_TestData.mat"
ndata<-readMat(fname)
nam<-names(ndata)
TrainData<-ndata$TrainData
train_label<-ndata$trainlabel
TestData<-ndata$TestData
test_label<-ndata$testlabel


## Random forest classification
Nclass<-length(unique(train_label))
source('bh_randomforest.R')
option="train"
str<-Sys.time()
RFmodel<-bh_randomforest(TrainData,train_label,option)
RFmodel$Nclass<-Nclass
print(Sys.time()-str)
gc()

str=Sys.time()
RFPrediction<-bh_randomforest(RFmodel,TestData,option="test")
print(Sys.time()-str)
gc()

RFPrediction_label<-RFPrediction$classifiedlabel

RFaccuracy = sum(RFPrediction_label == test_label)/length(test_label)

