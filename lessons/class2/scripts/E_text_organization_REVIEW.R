#' Title: Text Organization for Bag of Words
#' Purpose: Learn some basic cleaning functions & term frequency
#' Author: Ted Kwartler
#' email: edward.kwartler@faculty.hult.edu
#' License: GPL>=3
#' Date: Jan 18 2022
#'

# Set the working directory
setwd("~/Desktop/Hult_NLP_student_intensive/lessons/class2/data")

# Libs
library(tm)
library(RCurl)

# Options & Functions
options(stringsAsFactors = FALSE)
Sys.setlocale('LC_ALL','C')

tryTolower <- function(x){
  y <- NA
  tryError <- tryCatch(tolower(x), error = function(e) e)
  if (!inherits(tryError, 'error'))
    y <- tolower(x)
  return(y)
}

cleanCorpus<-function(corpus, customStopwords){
  corpus <- tm_map(corpus, content_transformer(qdapRegex::rm_url))
  corpus <- tm_map(corpus, content_transformer(tryTolower))
  corpus <- tm_map(corpus, removeWords, customStopwords)
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, removeNumbers)
  corpus <- tm_map(corpus, stripWhitespace)
  return(corpus)
}

# Create custom stop words
stops <- c(stopwords('english'), 'lol', 'smh')

# Data
#gitFile <- url('https://raw.githubusercontent.com/kwartler/Hult_NLP_student_intensive/main/lessons/class2/data/coffee.csv')
#text <- read.csv(gitFile)
text <- read.csv('coffee.csv', header=TRUE)

# As of tm version 0.7-3 tabular was deprecated
names(text)[1] <- 'doc_id' 

# Make a volatile corpus
txtCorpus <- VCorpus(DataframeSource(text))

# Preprocess the corpus
txtCorpus <- cleanCorpus(txtCorpus, stops)

# Make a Document Term Matrix or Term Document Matrix depending on analysis
txtDtm  <- DocumentTermMatrix(txtCorpus)
txtDtmM <- as.matrix(txtDtm)

# Examine
txtDtmM[1:5,c(490, 633:635,1748:1752)]

# Get the most frequent terms
topTermsA <- colSums(txtDtmM)

# Add the terms
topTermsA <- data.frame(terms = colnames(txtDtmM), 
                        freq = topTermsA, 
                        row.names = NULL)

# Review
head(topTermsA)

# Order
exampleReOrder <- topTermsA[order(topTermsA$freq, decreasing = T),]

# Examine a Word Frequency Matrix
head(exampleReOrder, 10)

# End

