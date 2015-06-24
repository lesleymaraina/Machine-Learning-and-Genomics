intall.packages('caret',dependencies=T)
intall.packages('caret')
install.packages('caret',dependencies=T)
install.packages(c("randomForest", "glmnet"), dependencies=T)
fullFeatureSet <- read.table("features.txt");
target <- scan("target.txt")
names(fullFeatureSet)
features <- fullFeatureSet
source("runLasso.R")
print(lassoFit)
#RSquared: correlation
print(lassoFit$resample)
#Picked the best model using root mean squared (RMSE)
#RMSE is a generic measurement of error, but its good to look at RMSE and Rsquared
print(coef(lassoModel, s=1e-4))
print(coef(lassoModel, s=1))
#look at value of weights when you varie lamda; beta goes to zero as you increase lambda
lassoPreds <- predict(lassoFit, newdata=features)
plot(target, lassoPreds)
source("runRF.R")
# Overall accuracy
print(randomforestFit)
# Accuracy per CV-fold
print(randomforestFit$resample)
# Variable Importance
print(rfModel$importance[order(rfModel$importance, decreasing=T),])
#use regularization to validate the controls
randomforestPreds <- predict(randomforestFit, newdata=features)
plot(target, randomforestPreds)
heatmap(cor(features, symm=T))
heatmap(cor(features))
# We will experiment with the weights that lasso regression produces when given
# a subset of the features. First, create a column vector specifying the names
# of a subset of the features with:
featureSubset <- c("Control", "H3k4me1", "H3k4me2", "H2az", "H3k27me3",
"H3k36me3", "H3k9me1", "H3k9me3", "H4k20me1")
# Now create the variable “features” which contains this subset of features:
features <- fullFeatureSet[featureSubset]
# You will now run lasso regression.
source("runLasso.R")
# coefficients are the beta values used for the linear model: print(coef(lassoModel, s=1))
lassoPreds <- predict(lassoFit, newdata=features)
plot(target, lassoPreds)
