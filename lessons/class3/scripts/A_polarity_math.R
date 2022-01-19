#' Title: Polarity Math
#' Purpose: Learn and calculate polarity 
#' Author: Ted Kwartler
#' email: edward.kwartler@hult.edu
#' License: GPL>=3
#' Date: Dec 28, 2020
#'

# Libs
library(qdap)
library(sentimentr)

# Examine lexicon examples
head(lexicon::hash_sentiment_huliu) #used in qdap's polarity default
head(lexicon::key_sentiment_jockers) #used in sentimentr  default
?sentiment

# Neutral
polarity('neutral neutral neutral')
sentiment('neutral neutral neutral', polarity_dt = lexicon::hash_sentiment_huliu)
(0 + 0 + 0)/sqrt(3)

# Amplifier
polarity('neutral very good')
sentiment('neutral very good', polarity_dt = lexicon::hash_sentiment_huliu)
(0 + 0.8 + 1)/sqrt(3)

# De-Amplifier
polarity('neutral barely good')
sentiment('neutral barely good', polarity_dt = lexicon::hash_sentiment_huliu)
(-0.8 + 1) /sqrt(3)

# Negation
polarity('neutral not good')
sentiment('neutral not good', polarity_dt = lexicon::hash_sentiment_huliu)
(-1 *(0 + 1)) / sqrt(3)

# Double Negation
polarity('not not good')
sentiment('not not good', polarity_dt = lexicon::hash_sentiment_huliu)
(-1*-1* (1)) / sqrt(3)

# Order doesn't matter in the context cluster
polarity('good not good')
sentiment('good not good', polarity_dt = lexicon::hash_sentiment_huliu)
(-1*(1 + 1)) / sqrt(3)

# You can also group by another column
fakeData <- data.frame(author = c('ted', 'meghan', 'vitaly'),
                       text = c('not good', 'very good', 'meh so so'))
fakeData
polarity(fakeData$text)
polarity(fakeData$text, grouping.var = fakeData$author)
sentiment_by(text.var    = fakeData$text,
             by          = fakeData$author,
             polarity_dt = lexicon::hash_sentiment_huliu)

# End
