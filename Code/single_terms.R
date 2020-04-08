library(tm)
library(wordcloud)
library(ggplot2)
library(SnowballC)

wd<-("C:/Users/aleks/OneDrive/Pulpit/OpinionMining/R/AllCorpus")
dir(wd)
setwd(wd)
docs <- Corpus(DirSource(wd))

#DocsCopy <- docs

docs <- tm_map(docs, stripWhitespace)
docs <- tm_map(docs, PlainTextDocument)

StW<-read.table("C:/Users/aleks/OneDrive/Pulpit/OpinionMining/R/AllStopWords.txt")
StWW<-as.character(StW$V1)
docs <- tm_map(docs, removeWords, StWW)
docs <- tm_map(docs, PlainTextDocument)

dtm <- DocumentTermMatrix(docs)
dtm
inspect(dtm[1:1, 10:15])

dtm # checking the dtm size
filenames <- list.files(getwd(),pattern="*.txt")
filenames <-c(filenames)
filenames # checking the filenames length
rownames(dtm)<-filenames

tdm <- t(dtm) 
inspect(dtm[1, 10:15])
inspect(tdm[10:15,1])

freq <- colSums(as.matrix(dtm))
length(freq)
ord <- order(freq,decreasing=TRUE)
freq[head(ord)]
freq[tail(ord)]

dtmr <-DocumentTermMatrix(docs, control=list(wordLengths=c(3, 20),bounds = list(global = c(2,Inf))))
filenames <- list.files(getwd(),pattern="*.txt")
filenames <-c(filenames)
rownames(dtmr)<-filenames

#Useful only of all texts
dtmr1 = removeSparseTerms(dtmr, 0.6)
filenames <- list.files(getwd(),pattern="*.txt")
filenames <-c(filenames)
rownames(dtmr1 )<-filenames
dtmr
dtmr1

m <- as.matrix(dtmr)
write.csv(m, file="DocumentTermMatrix.csv")
m1 <- as.matrix(dtmr1)
write.csv(m1, file="SparseDocumentTermMatrix.csv") 

freqr <- colSums(as.matrix(dtmr))
length(freqr)
freq <- sort(freqr, decreasing=TRUE)
head(freq, 200)

#findFreqTerms(dtmr,lowfreq=80)

wf=data.frame(word=names(freq),freq=freq)
library(ggplot2)
p <- ggplot(subset(wf, freq>500), aes(x = reorder(word, -freq), y = freq))
p <- p + geom_bar(stat="identity")
p <- p + theme(axis.text.x=element_text(angle=45, hjust=1))
p

set.seed(42)
wordcloud(names(freq),freq,min.freq=150,colors=brewer.pal(6, "Dark2"))
