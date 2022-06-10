## Employee Attrition Prediction

## Attrition as target in given data and rest of all as predictors.

setwd("D:/Data Science/R Project/Project2")
library(csvread)
df=read.csv("R_ML_Project_2_Emplo.csv")
View(df)

#check Null Value in dataset
sum(is.na(df))

#check basic Info
ncol(df)
nrow(df)
names(df)

#probability
prop.table(table(df$Attrition))

#Encoding of Column
df$Attrition <- ifelse(df$Attrition=="Yes", 1, 0)
df$Attrition<-as.factor(df$Attrition)

# Splitting dataset
library(caTools)
split = sample.split(df$Attrition, SplitRatio = 0.8)
split
train_reg = subset(df, split == "TRUE")
test_reg = subset(df, split == "FALSE")
dim(train_reg)
dim(test_reg)

#---------------------------- Logistic Regression--------------------------------#

library(caTools)

# Training model
lormodel = glm(Attrition ~ TotalWorkingYears + OverTime + YearsWithCurrManager + MonthlyIncome + YearsAtCompany,data = train_reg,family = "binomial")
lormodel


# Summary
summary(lormodel)

# Predict train data based on model
pred = predict(lormodel,train_reg, type = "response")

#Conf matrix of model
confmatrix = table(Actual_Value=train_reg$Attrition,Predicted_value = pred > 0.5)
confmatrix

#Accuracy of train data model
accuracy =(confmatrix[[1,1]] + confmatrix[[2,2]])/ sum(confmatrix)
print(accuracy)

# Predict test data based on model
pred = predict(lormodel,test_reg, type = "response")

#Conf matrix of model
confmatrix = table(Actual_Value=test_reg$Attrition,Predicted_value = pred > 0.5)
confmatrix

#Accuracy of test data model
accuracy =(confmatrix[[1,1]] + confmatrix[[2,2]])/ sum(confmatrix)
print(accuracy)


#---------------------------- Random Forest --------------------------------#

library(randomForest)

# Training model
rfmodel = randomForest(Attrition ~ TotalWorkingYears + OverTime + YearsWithCurrManager + MonthlyIncome + YearsAtCompany,data = train_reg)
rfmodel


# Summary
summary(rfmodel)

# Predict train data based on model
pred = predict(rfmodel,train_reg, type = "response")

#Conf matrix of model
confmatrix = table(Actual_Value=train_reg$Attrition,Predicted_value = pred)
confmatrix

#Accuracy of train data model
accuracy =(confmatrix[[1,1]] + confmatrix[[2,2]])/ sum(confmatrix)
print(accuracy)

# Predict test data based on model
pred = predict(rfmodel,test_reg, type = "response")

#Conf matrix of model
confmatrix = table(Actual_Value=test_reg$Attrition,Predicted_value = pred)
confmatrix

#Accuracy of test data model
accuracy =(confmatrix[[1,1]] + confmatrix[[2,2]])/ sum(confmatrix)
print(accuracy)


#---------------------------------- svm ----------------------------------------#

library(e1071)

# Training model
svmodel = svm(Attrition ~ TotalWorkingYears + OverTime + YearsWithCurrManager + MonthlyIncome + YearsAtCompany,data = train_reg)
svmodel


# Summary
summary(svmodel)

# Predict train data based on model
pred = predict(svmodel,train_reg, type = "response")

#Conf matrix of model
confmatrix = table(Actual_Value=train_reg$Attrition,Predicted_value = pred)
confmatrix

#Accuracy of train data model
accuracy =(confmatrix[[1,1]] + confmatrix[[2,2]])/ sum(confmatrix)
print(accuracy)

# Predict test data based on model
pred = predict(svmodel,test_reg, type = "response")

#Conf matrix of model
confmatrix = table(Actual_Value=test_reg$Attrition,Predicted_value = pred)
confmatrix

#Accuracy of test data model
accuracy =(confmatrix[[1,1]] + confmatrix[[2,2]])/ sum(confmatrix)
print(accuracy)


#---------------------------------- Naivy Bayes ----------------------------------------#

library(e1071)

# Training model
nbmodel = naiveBayes(Attrition ~ TotalWorkingYears + OverTime + YearsWithCurrManager + MonthlyIncome + YearsAtCompany,data = train_reg)
nbmodel


# Summary
summary(nbmodel)

# Predict train data based on model
pred = predict(nbmodel,train_reg, type = "class")

#Conf matrix of model
confmatrix = table(Actual_Value=train_reg$Attrition,Predicted_value = pred)
confmatrix

#Accuracy of train data model
accuracy =(confmatrix[[1,1]] + confmatrix[[2,2]])/ sum(confmatrix)
print(accuracy)

# Predict test data based on model
pred = predict(nbmodel,test_reg, type = "class")

#Conf matrix of model
confmatrix = table(Actual_Value=test_reg$Attrition,Predicted_value = pred)
confmatrix

#Accuracy of test data model
accuracy =(confmatrix[[1,1]] + confmatrix[[2,2]])/ sum(confmatrix)
print(accuracy)


#--------------------------------- Decision Tree--------------------------------#

library(ROSE)
library(rpart)

dtmodel=rpart(Attrition ~ TotalWorkingYears + OverTime + YearsWithCurrManager + MonthlyIncome + YearsAtCompany,data = train_reg)
dtmodel


# Summary
summary(dtmodel)

# Predict train data based on model
pred = predict(dtmodel,train_reg, type = "class")

#Conf matrix of model
confmatrix = table(Actual_Value=train_reg$Attrition,Predicted_value = pred)
confmatrix

#Accuracy of train data model
accuracy =(confmatrix[[1,1]] + confmatrix[[2,2]])/ sum(confmatrix)
print(accuracy)

# Predict test data based on model
pred = predict(dtmodel,test_reg, type = "class")

#Conf matrix of model
confmatrix = table(Actual_Value=test_reg$Attrition,Predicted_value = pred)
confmatrix

#Accuracy of test data model
accuracy =(confmatrix[[1,1]] + confmatrix[[2,2]])/ sum(confmatrix)
print(accuracy)

