library(tm)
library(topicmodels)
library(lsa)
library(scatterplot3d)
library(ggplot2)

wd<-("D:/vader/ProductCluster")
dir(wd)
setwd(wd)

docs <- Corpus(DirSource(wd))

docs <- tm_map(docs, stripWhitespace)
docs <- tm_map(docs, PlainTextDocument)
docs <- tm_map(docs ,removePunctuation) 
docs <- tm_map(docs , tolower)   
docs <- tm_map(docs, stemDocument)

StW<-read.table("D:/vader/Inne/AllStopWords.txt")
StWW<-as.character(StW$V1)
docs <- tm_map(docs, removeWords, c(StWW, stopwords('english')))
docs <- tm_map(docs, PlainTextDocument)

dtm <- DocumentTermMatrix(docs)

filenames <- list.files(getwd(),pattern="*.txt")
filenames <-c(filenames)
rownames(dtm)<-filenames

dist.mat <- dist(dtm) 
dist.mat 
fit <- cmdscale(dist.mat, eig = TRUE, k = 2)  
fit 
points <- data.frame(x = fit$points[, 1], y = fit$points[, 2]) 
points 

d <- dist(fit$points, method="euclidian")    
# 2 clusters 
kfit11 <- kmeans(d, 2)   
kfit11  
library(cluster) 
clusplot(as.matrix(d), kfit11$cluster, color=T, shade=T, labels=2, lines=0) 
# 3 clusters 
kfit11 <- kmeans(d, 3)   
kfit11  
library(cluster) 
clusplot(as.matrix(d), kfit11$cluster, color=T, shade=T, labels=2, lines=0) 
