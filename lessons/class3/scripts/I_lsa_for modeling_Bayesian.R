#' Title: LSA for Modeling - Bayes
#' Purpose: use LSA to reduce dimensions and create a Bayesian model
#' Author: Ted Kwartler
#' email: edward.kwartler@faculty.hult.edu
#' License: GPL>=3
#' Date: Jan 18 2022
#' Other Options worth exploring
#' https://cran.r-project.org/web/packages/textmineR/vignettes/c_topic_modeling.html
#' https://cran.r-project.org/web/packages/RTextTools/index.html

# Set the working directory
setwd("~/Desktop/Hult_NLP_student_intensive/lessons/class3/data")

# Libs
library(tm)
library(lsa)
library(e1071)
library(yardstick)
library(ggplot2)

# Bring in our supporting functions
tryTolower <- function(x){
  y = NA
  try_error = tryCatch(tolower(x), error = function(e) e)
  if (!inherits(try_error, 'error'))
    y = tolower(x)
  return(y)
}

cleanCorpus<-function(corpus, customStopwords){
  corpus <- tm_map(corpus, content_transformer(qdapRegex::rm_url))
  corpus <- tm_map(corpus, removeNumbers)
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, stripWhitespace)
  corpus <- tm_map(corpus, content_transformer(tryTolower))
  corpus <- tm_map(corpus, removeWords, customStopwords)
  return(corpus)
}

# Options & Functions
options(stringsAsFactors = FALSE, scipen = 999)
Sys.setlocale('LC_ALL','C')

# Create custom stop words
stops <- c(stopwords('SMART'), 'car', 'electronic')

# Bring in some data
autoPth <- list.dirs()[grep('auto', list.dirs())]
sciPth  <- list.dirs()[grep('sci', list.dirs())]
carCorp <- VCorpus(DirSource(autoPth))
electronicCorp <- VCorpus(DirSource(sciPth))

# Clean each one
carCorp        <- cleanCorpus(carCorp, stops)
electronicCorp <- cleanCorpus(electronicCorp, stops)

# Combine
allPosts <-  c(carCorp,electronicCorp)
rm(carCorp)
rm(electronicCorp)
gc()

# Construct the Target
yTarget <- c(rep(1,1000), rep(0,1000)) #1= about cars, 0 = electronics

# Make TDM; lsa docs save DTM w/"documents in colums, terms in rows and occurrence frequencies in the cells."!
allTDM <- TermDocumentMatrix(allPosts, 
                             control = list(weighting = weightTfIdf))
allTDM

# Get 20 latent topics
##### Takes awhile, may crash small computers, so saved a copy
#lsaTDM <- lsa(allTDM, 20)
#saveRDS(lsaTDM, 'lsaTDM_tfidf.rds')
lsaTDM <- readRDS('lsaTDM_tfidf.rds')

# Extract the document LSA values
docVectors <- as.data.frame(lsaTDM$dk)
head(docVectors)

# Append the target
docVectors$yTarget <- as.factor(yTarget)

# Sample (avoid overfitting)
set.seed(1234)
idx <- sample(1:nrow(docVectors),.6*nrow(docVectors))
training   <- docVectors[idx,]
validation <- docVectors[-idx,]

# Fit the Bayesian Model
fit <- naiveBayes(yTarget ~ ., data = training)

# Training Preds
pred <- predict(fit, training)
table(pred, training$yTarget)

# Validation Preds
pred <- predict(fit, validation)
(confMat <-table(pred, validation$yTarget))

# Simple model evals
summary(conf_mat(confMat))
autoplot(conf_mat(confMat))

### NOTICE that we built a giant DTM then used LSA, then sampled.  
### In most practical applications you will not know the test set and 
### so this workflow wont work.  
### You can use this method for the case since all records are known though.
# End