library(tm)
library(wordcloud)
library(ggplot2)
library(SnowballC)

# path :
wd<-("C:\Users\szkli\Downloads\AllCorpus-20191216T171253Z-001\AllCorpus\Nowy folder\Nowy folder")
dir(wd)
setwd(wd)
docs <- Corpus(DirSource(wd))

#DocsCopy <- docs

docs <- tm_map(docs, stripWhitespace)
docs <- tm_map(docs, PlainTextDocument)

StW<-read.table("C:\Users\szkli\Downloads\AllCorpus-20191216T171253Z-001\AllCorpus\AllStopWords.txt")
StWW<-as.character(StW$V1)
docs <- tm_map(docs, removeWords, StWW)
docs <- tm_map(docs, PlainTextDocument)

NgramTokenizer = function(x) {
  unlist(lapply(ngrams(words(x), 3), paste, collapse = " "),
         use.names = FALSE)
}
dtm_n <- DocumentTermMatrix(docs, control = list(tokenize = NgramTokenizer))
dtm_n
filenames <- list.files(getwd(),pattern="*.txt")
filenames <-c(filenames)
rownames(dtm_n)<-filenames

freqr <- colSums(as.matrix(dtm_n))
length(freqr)
freq <- sort(freqr, decreasing=TRUE)
head(freq, 200)

#findFreqTerms(dtmr,lowfreq=80)

wf=data.frame(word=names(freq),freq=freq)
library(ggplot2)
p <- ggplot(subset(wf, freq> 10), aes(x = reorder(word, -freq), y = freq))
p <- p + geom_bar(stat="identity")
p <- p + theme(axis.text.x=element_text(angle=45, hjust=1))
p

