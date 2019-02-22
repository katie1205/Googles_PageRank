
#Given an n x n transition matrix M of a directed (and strongly connected) graph and a starting rank vector, v, of length n, 
#This function uses the power method to compute the rank.
#The power method is the process of iteratively multiplying a vector by a matrix, 
#generating the sequence: v, Mv, M^2v, M^3v,......., M^nv to estimate the limit of M^nv as n-> infinity. 

#Function
Page_Rank<-function(M,v){
  for(i in c(1:1000000)){
    v<-M%*%v
  }
  print(v)
}

#Sample application:
v<-c(rep(1/4,4))
M<-matrix(c(0,1/3,1/3,1/3,1/2,0,0,1/2,1,0,0,0,0,1/2,1/2,0),nrow=4,ncol=4)

Page_Rank(M,v)
