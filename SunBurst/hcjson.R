hcjson<-function(merge){
  
  final<-list()
  for (i in 1:nrow(merge)){
    left <- merge[i, 1]
    right <- merge[i, 2]
    
    if(left<0 & right<0){   final[[i]]=list(name=paste("idx",i),children=list(list(name=paste("leaf",-left),size=1),list(name=paste("leaf",-right),size=1)),size=1)    }
    if(left<0 & right>0){   final[[i]]=list(name=paste("idx",i),children=list(final[[right]],list(name=paste("leaf",-left),size=1)),size=1)    }
    if(left>0 & right>0){   final[[i]]=list(name=paste("idx",i),children=list(final[[left]],final[[right]]),size=1)    }
  }
  toexclude<-c()
  for (i in 1:nrow(merge)){
    left <- merge[i, 1]
    right <- merge[i, 2]
    if(left<0 & right>0){   
      toexclude<-c(toexclude,right)
    }
    
    if(left>0 & right>0){
      toexclude<-c(toexclude,left,right)
    }
  }
  final<-list(name="root",children=final[setdiff(c(1:nrow(merge)),toexclude)])
  final
}