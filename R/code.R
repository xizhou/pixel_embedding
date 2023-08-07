trans <- function(x,k=400,flatten=c("c","r","d"),filter=c(3,26,3,26))
{
   .offdiag <- function(m,offset)
   {
      n <- nrow(m)
      if(offset<n)
      {
         s <- seq(nrow(m)-offset)
         y <- diag(m[,-s, drop=FALSE])
      }
      else if(offset==n)
         y <- diag(m)
      else
      {
         s <- seq(offset-nrow(m))
         y <-  diag(m[-s,, drop=FALSE])
      }
      y
   }
   if(is.null(colnames(x)))
      colnames(x) <-  paste0("x",seq(ncol(x)))
   n=ncol(x)
   s <- matrix(1:n,nrow=n^0.5,byrow=F)
   s <- s[c(filter[1]:filter[2]),c(filter[3]:filter[4])]
   s <- c(s)
   s <- colnames(x)[s]
   X <- ""
   if("c" %in% flatten)
   {
      X1 <- x
      if(is.null(k))
         id <- s
      else
         id <- sample(s,k)
      X1 <- X1[,colnames(X1)%in%id]
      X1 <- as.matrix(X1)
      X1 <- round(X1,1)
      nm <- rep(colnames(X1),each=nrow(X1))
      X1[] <- str_c(nm,X1,sep=":")
      X1 <- apply(X1,1,str_c,collapse=" ")
      X <- str_c(X,X1,sep=" ")
   }
   if("r" %in% flatten)
   {
      idx <- matrix(1:n,nrow=n^0.5,byrow=F)
      idx <- t(idx[nrow(idx):1,])
      x90 <- x[,as.numeric(idx)]
      X2 <- x90
      if(is.null(k))
         id <- s
      else
         id <- sample(s,k)
      X2 <- X2[,colnames(X2)%in%id]
      X2 <- as.matrix(X2)
      X2 <- round(X2,1)
      nm <- rep(colnames(X2),each=nrow(X2))
      X2[] <- str_c(nm,X2,sep=":")
      X2 <- apply(X2,1,str_c,collapse=" ")
      X <- str_c(X,X2,sep=" ")
   }
   if("d" %in% flatten)
   {
      idx <- matrix(1:n,nrow=n^0.5,byrow=F) 
      idx <- lapply(seq((2*n^0.5-1)+1),.offdiag,m=idx) %>% unlist
      x45 <- x[,idx]
      X3 <- x45
     if(is.null(k))
         id <- s
      else
         id <- sample(s,k)
      X3 <- X3[,colnames(X3)%in%id]
      X3 <- as.matrix(X3)
      X3 <- round(X3,1)
      nm <- rep(colnames(X3),each=nrow(X3))
      X3[] <- str_c(nm,X3,sep=":")
      X3 <- apply(X3,1,str_c,collapse=" ")
      X <- str_c(X,X3,sep=" ")
   }
   X <- gsub("^ ","",X)
   X
}
