#' Title: Regression 
#' Purpose: Learn about a regression model
#' Author: Ted Kwartler
#' email: edward.kwartler@faculty.hult.edu
#' License: GPL>=3
#' Date: Jan 18 2022
#'

# Libs

# Setwd
setwd("~/Desktop/Hult_NLP_student_intensive/lessons/class3/data")

# Data
houses <-read.csv('BostonHousing.csv')
houses$CAT..MEDV <-NULL #not used categorical Y var

# Partitioning; get 10% test set
splitPercent <- round(nrow(houses) %*% .9)

set.seed(1234)
idx      <- sample(1:nrow(houses), splitPercent)
trainSet <- houses[idx, ]
testSet  <- houses[-idx, ]

# Visualize a relationship; do you see a trend
houses <- houses[order(houses$MEDV), ]
plot(houses$RM, houses$MEDV, xlim=c(0,10), ylim = c(-35, 50))

# Let's make up a model; medianValue = 0 + 1*rooms
# This means for every room it adds 1 to the median value
abline(0,1, col='red') #intercept, then slope

# Fit a model (univariate) with no intercept
# The equation of this model is the Y ~ the variable RM and with +0 we are forcing there to be NO beta-naught
fit <- lm(MEDV ~ RM + 0, trainSet)

# Examine
fit

# Add the function line
abline(a = 0, #intercept
       b = coefficients(fit),
       col='red') #slope for every room in an house it adds 3.65 to the median value

# Fit a model with the intercept by removing the +0 in the formula, representing the steady state of median values
fit2 <- lm(MEDV ~ RM, trainSet)

# Examine
fit2

# Add the function line
abline(a = coefficients(fit2)[1], #intercept
       b = coefficients(fit2)[2], col='blue') #slope

# Get some predictions on the training set
manualPreds <- trainSet$RM #slope is 1 so beta =1 X the actual value
preds1      <- predict(fit, trainSet) 
preds2      <- predict(fit2, trainSet)

# Examine predictions since this is one of the first times we did predict() & compare to the actual values
data.frame(preds   = head(preds1),
           actuals = head(trainSet$MEDV))

# Manual RMSE
manualErr <- (trainSet$MEDV - manualPreds)^2
fitErr    <- (trainSet$MEDV - preds1)^2
fit2Err   <- (trainSet$MEDV - preds2)^2 

sqrt(mean(manualErr))
sqrt(mean(fitErr))
sqrt(mean(fit2Err))

# Now validation
manualPredsVal <- testSet$RM # Again beta = 1 X actual values
preds1Val      <- predict(fit, testSet)
preds2Val      <- predict(fit2, testSet)

# Get manual RMSE
manualErrVal <- (testSet$MEDV - manualPredsVal)^2
fitErrVal    <- (testSet$MEDV - preds1Val)^2
fit2ErrVal   <- (testSet$MEDV - preds2Val)^2 

sqrt(mean(manualErrVal))
sqrt(mean(fitErrVal))
sqrt(mean(fit2ErrVal))

## Of course we would actually calculate the RMSE in a function not this manual way.
ModelMetrics::rmse(testSet$MEDV, manualPredsVal)
ModelMetrics::rmse(testSet$MEDV, preds1Val)
ModelMetrics::rmse(testSet$MEDV, preds2Val)

# Or we can build a more robust model with all variables
finalFit <- lm(MEDV ~ ., trainSet)
finalFit

# Quick example
finalPreds <- predict(finalFit, testSet)
ModelMetrics::rmse(testSet$MEDV, finalPreds)

# End
