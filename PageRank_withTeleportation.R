#Page_Rank_2
#Estimates modified Page Rank of a network of n pages, given:
#   + A probability "1-Beta" of teleporting
#   + An initial rank vector, v
#   + A stochastic n x n matrix M
Page_Rank_2<-function(M,v,Beta){
  n<-length(v)
  for (i in c(1:1000000)){
    v<-M%*%v + (1-Beta)*c(rep(1/n),n)
  }
}
