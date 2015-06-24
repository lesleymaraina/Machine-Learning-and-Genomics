library(caret)
#for the decision tree, make a decision based on the value of the features
#random forest: takeks random samples of data; doesnt use all features and only test on random samples 
rfGrid <- expand.grid(mtry=floor(ncol(features)/3))

randomforestFit <- train(features, target, method="rf", 
                         trControl=fitControl, tuneGrid=rfGrid,
                         ntree=100)
rfModel <- randomforestFit$finalModel

# Overall accuracy
print(randomforestFit)

# Accuracy per CV-fold
print(randomforestFit$resample)

# Variable Importance
print(rfModel$importance[order(rfModel$importance, decreasing=T),])
