bh_naInfRemoval<-function(Data)
  
{
  Data = as.matrix(Data)
  # Na Removal
  Nind<-which(is.na(Data))
  Data[Nind]<-0
  
  # Inf Removal
  Nind<-which(is.infinite(Data))
  Data[Nind]<-0
  
  return(Data)
}