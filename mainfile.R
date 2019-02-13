rm(list=ls())
pstrttime<-Sys.time()
old_dir<-("/share/projects/obelix/NOBACKUP/triskele/rcodes")
setwd(old_dir)
getwd()
source('bh_loadLib.R')
bh_loadLib()
#### ++++++++++ Options+++++++++++++++
FullImageClassification=TRUE

datapathname<-'/share/projects/obelix/NOBACKUP/triskele/data/'
GTPathname<-'/share/projects/obelix/NOBACKUP/triskele/data/'

### hrd, tif files ###################
setwd(datapathname)
# OrgImg_tif_filenames<-list.files(path=OrgImgPathname, pattern= "tif")
# OrgImgfilenames<-list.files(path=OrgImgPathname, pattern= "hdr")
# GTfilenames<-list.files(path=GTPathname, pattern= "tif")

GTfilenames<-'GTSarea7.tif'
OrgImgfilenames<-'result.tif'
######################
Data<-numeric(0)

## Ground Truth read
setwd(GTPathname)
GTImage<-readGDAL(GTfilenames[1])
GTImage <-GTImage@data
nsz<-dim(GTImage)
Sindex<-1:(nsz[1])
L <-unique(GTImage)
orglabel<-GTImage(which(GTImage>0))

## Read the original image
setwd(OrgImgPathname)
fname<-OrgImgfilenames[1]
ff<-substr(fname,1,nchar(fname)-4)
OrgImg<-readGDAL(ff)
#OrgImg<-readGDAL(OrgImgfilenames[1]) # for JP2 format

OrgImg<-OrgImg@data
sz<-dim(OrgImg)
nrow<-sz[1]
ncol<-sz[2]
zero_index<-which(OrgImg[1]==0)
Data<-OrgImg


setwd(old_dir)
source('bh_naInfRemoval.R')
Data<-bh_naInfRemoval(Data)


#sss<-bh_randomsubsetsamples(orglabel,"Percentage",NPer[outer])
sss<-bh_randomsubsetsamples(orglabel,"No_of_samples",500)
TrainData<-Data[sss$tr_index,];train_label<-orglabel[sss$tr_index];
TestData<-Data[-sss$tr_index,];testlabel<-orglabel[-sss$tr_index]

gc()
Nclass<-length(unique(trainlabel))
## Random Forest
setwd(old_dir)
source('bh_randomforest.R')
option="train"
str<-Sys.time()
RFmodel<-bh_randomforest(TrainData,trainlabel,option)
RFmodel$Nclass<-Nclass
print(Sys.time()-str)

### seq. Implementation for testing
str=Sys.time()
RFPrediction<-bh_randomforest(RFmodel,TestData,option="test")
print(Sys.time()-str)

#confusion matrix
source('bh_confusionmat.R')
RAcc<-bh_confusionmat(testlabel,RFPrediction$classifiedlabel,option="CI")

# RF classification for whole image
str=Sys.time()
RFPrediction<-bh_randomforest(RFmodel,ImageData,option="test")
print(Sys.time()-str)

predicted_img<-reshape(as.matrix(RFPrediction$classifiedlabel),nrow,ncol)
predicted_img<-t(predicted_img)

setwd(old_dir)
source('bh_rasterclassificationMap.R')
rc<-bh_rasterclassificationMap(predicted_img,oorrimg)
savepname<-'/share/home/damodara/SIRSWoody/DATA/ATC/results/DAP_MaxTree'
setwd(savepname)
#fn<-OrgImgfilenames[1]
fn<-'ATC_DAPMaxTree_NDVI_DAPMaxTree_Green_classified_img.tif'
rc<-writeRaster(rc, filename=fn, format="GTiff", datatype='INT1U', overwrite=TRUE)
setwd(old_dir)



