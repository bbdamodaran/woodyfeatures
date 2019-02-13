bh_outlierremoval<-function(Foreground,Background,probs)
{
  # This function removes the back ground pixels which are similar with Foreground
  # probs - percentile of values to remove
  require(flexclust)
  foregrd_mean = colMeans(Foreground)
  foregrd_mean = matrix(foregrd_mean, nrow=1)
  distance = dist2(foregrd_mean, Background, method = "euclidean", p=2)
  dist_percentile = quantile(distance, probs= 0.25)
  nonoutlier_index = which(distance>=dist_percentile)
  # Background = Background[nonoutlier_index,]
  
  return(nonoutlier_index)
  
  
  
}