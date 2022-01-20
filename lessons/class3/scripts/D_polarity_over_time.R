#' Title: Polarity Over Time
#' Purpose: Learn to calculate polarity 
#' Author: Ted Kwartler
#' email: edward.kwartler@faculty.hult.edu
#' License: GPL>=3
#' Date: Dec 28, 2020
#'

# Libraries
library(lubridate) #not used here but useful for extracting days, months, hours etc as grouping variables
library(tm)
library(sentimentr)
library(RCurl)

# Options & Functions
options(stringsAsFactors = FALSE)
Sys.setlocale('LC_ALL','C')

# Get the file
gitFile <- url('https://raw.githubusercontent.com/kwartler/Hult_NLP_student_intensive/main/lessons/class2/data/chardonnay.csv')
txt <- read.csv(gitFile)

# Date Time Class & Order
head(txt$created,2) #examine
txt$created <- as.POSIXct(txt$created)
head(sort(txt$created),2) #examine to show difference

# Order the entire DF
txt <- txt[order(txt$created),]

# Get sentiment for each individual document which was ordered by date
pol <- sentiment_by(txt$text, txt$id)

# Append the document average sentiment to the original data
txt$pol <- pol$ave_sentiment

# Plot a moving average merely as an example; kind of a nonsense result
par(mfrow=c(2,1))
plot(forecast::ma(txt$pol,24), type = 'l')
plot(cumsum(grepl('marvin', txt$text,ignore.case = T)), type = 'l')

# End