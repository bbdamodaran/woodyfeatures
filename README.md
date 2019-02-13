# woodyfeatures
This repository contains the R codes used for classification of woody features from pre-computed attribute profiles.

The classification of woody features is perfomed using Random Forest classifier. Here we have used simple strategy to automatically select the background training pixels from the data for non-woody features (background class). The input images read using GDAL package in R, and also the output image ( in tif) is also written using the GDAL package. Please see: 'bh_loadLib.R' for the list packages required to run the codes in the repository. The input images are large, you can use "bh_imagecropindex.R" to crop the data

In the code, you have the change the path of the input data (local directory where the data is located)

ranger package is used to run the Random Forest clasifier in parallel

To run the codes: please see: "mainfile.R", and "SIRS_SingleFile_RF_Train_Test.R"




