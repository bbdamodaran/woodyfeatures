# woodyfeatures
This repository contains the R codes used for classification of woody features from pre-computed attribute profiles.

The classification of woody features is perfomed using Random Forest classifier. Here we have used simple strategy to automatically select the background training pixels from the data for non-woody features (background class). The input images read using GDAL package in R, and also the output image is also written using the GDAL package. Please see: 'bh_loadLib.R' for the list packages required to run the codes in the repository

In the code, you have the change the path of the input data (local directory where the data is located)


