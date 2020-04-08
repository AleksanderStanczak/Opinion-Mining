data<-read.csv("D:/vader/data.csv")
dataf<-data[,-1]

library(ggplot2)

data <- as.data.frame.matrix(data)

dataf <- as.data.frame(sapply(dataf, as.numeric)) #<- sapply is here

dataf[complete.cases(dataf), ]


filenames <-c(data$brand)
rownames(dataf)<-filenames

data12 <- dataf[,c(1:2)]
data13 <- dataf[,c(1,3)]
data14 <- dataf[,c(1,4)]


(dist.mat <- dist(dataf) )

fit <- cmdscale(dist.mat, eig = TRUE, k = 2)  
fit
points <- data.frame(x = fit$points[, 1], y = fit$points[, 2]) 
points 

ggplot(points, aes(x,y))+geom_point()+geom_text(aes(label=rownames(data)))

d <- dist(fit$points, method="euclidian")    
# 2 clusters 
kfit11 <- kmeans(d, 3)   
kfit11  
library(cluster) 
c<-clusplot(as.matrix(d), kfit11$cluster, color=T, shade=T, labels=2, lines=0) 