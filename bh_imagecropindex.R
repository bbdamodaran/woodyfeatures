bh_imagecropindex<-function(st_row, end_row, st_col, end_col, orgimg_dim)
{
# this function returns the position of the pixel indexes in the image (desired region
#to crop) according the rgdal ordering


indxx<-1:orgimg_dim[1]*orgimg_dim[2]
indimg<-reshape(as.matrix(indxx), orgimg_dim[2], orgimg_dim[1])
indimg<-t(indimg)

subindex<-indimgt[st_row:end_row, st_col:end_col]
dim<-dim(subindex)
pos_indx<-reshape(subindex, dim[1]*dim[2],1)

#subimg<-OrgImg[pos_indx,]
return(pos_indx=pos_indx, crop_dim=dim)
}