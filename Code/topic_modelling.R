 library(tm)
 library(topicmodels) 
 library(lsa)
 library(scatterplot3d)
 library(ggplot2)

mydata = read_lines("D:/vader/all.txt") %>% stringi::stri_trim_both() %>% `[`(. != "")
#wd<-("D:/vader/Comments")
#dir(wd)
#setwd(wd)

#docs <- Corpus(DirSource(wd))

docs <- Corpus(VectorSource(mydata))

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

dtm1 = dtm
dtm<-dtm1[,-1]

raw.sum=apply(dtm,1,FUN=sum) 
raw.sum
mmm<-nrow(dtm[raw.sum!=0,])
dtm2<-dtm[raw.sum!=0,]
dtm2
NN<-nrow(dtm2)
dtm2<-dtm
NN<-nrow(dtm)

rowTotals <- apply(dtm2 , 1, sum) 
dtm.new   <- dtm2[rowTotals> 0, ]

#__________LDA Topic Modelling______________________
burnin <- 4000
iter <- 2000
thin <- 500
seed <-list(2003,5,63,100001,765)
nstart <- 5
best <- TRUE
k <- 3

ldaOut <-LDA(dtm.new, k, method="Gibbs", control=list(nstart=nstart, seed = seed, best=best, burnin = burnin, iter = iter, thin=thin))
#str(ldaOut)

ldaOut.terms <- as.matrix(terms(ldaOut,8))
ldaOut.terms

topicProbabilities <- as.data.frame(ldaOut@gamma)
#topicProbabilities

ldaOut.topics <- as.matrix(topics(ldaOut))
#ldaOut.topics 

topic1comments = c()
topic2comments = c()
topic3comments = c()

for (i in c(1:length(mydata))) {
  if (ldaOut.topics[i,1] == 1) {
    topic1comments = c(topic1comments, mydata[i])
  }
  else if (ldaOut.topics[i,1] == 2) {
    topic2comments = c(topic2comments, mydata[i])
  }
  else {
    topic3comments = c(topic3comments, mydata[i])
  }
}

write(topic1comments, "D:/vader/Topics/topic1.txt")
write(topic2comments, "D:/vader/Topics/topic2.txt")
write(topic2comments, "D:/vader/Topics/topic3.txt")

