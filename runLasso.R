library(caret)
fitControl <- trainControl( 
    method="repeatedcv",
    number=10,
    ## repeated once
    repeats=1,
    verboseIter=T)

lassoGrid <- expand.grid(alpha=1, lambda=10^seq(-6, 2, 1))#sets up paramenters u want to try; lamdba how much you want to penalize the weights
#train models based on features
# lambda: 
lassoFit <- train(features, target, method="glmnet",
                  trControl=fitControl, tuneGrid=lassoGrid) #output linear model used to predict future data behavior
lassoModel <- lassoFit$finalModel #selects 

# run this line of code to put new data into the linear model created "lassofit": lassoPreds <- predict(lassoFit, newdata=features) 
#visualize the new data in a dotplot: plot(target, lassoPreds)

# Overall accuracy
print(lassoFit)

# Accuracy per CV-fold (for best model)
print(lassoFit$resample)

# We can inspect the coefficients for different values of the
# L1 penalty lambda - play around and see what happens.


# We can also plot the entire regularization path
# The numbers shown are the feature (column) ids - to get the name of the
# feature, you can do colnames(features)[10], for instance.
plot(lassoModel, "lambda", label=T)
