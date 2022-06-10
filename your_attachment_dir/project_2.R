## Employee Attrition Prediction

## Attrition as target in given data and rest of all as predictors.

setwd("D:/Data Science/R Project/Project2")

library(csvread)
empdata=read.csv("R_ML_Project_2_Emplo.csv")
View(empdata)

#check Null Value in dataset
sum(is.na(empdata))

#check basic Info
ncol(empdata)
nrow(empdata)
names(empdata)

#------------------------------------Logistic Regression------------------------------#
library(caTools)

#probability
prop.table(table(empdata$Attrition))

#Label encoding on Attrition column
empdata$Attrition = ifelse(empdata$Attrition=="Yes", 1, 0)
empdata$Attrition = as.factor(empdata$Attrition)
View(empdata)

## Fit the model
logestic_model = glm(Attrition ~ TotalWorkingYears + OverTime + YearsWithCurrManager + MonthlyIncome + YearsAtCompany,data = empdata,family=binomial(link="logit"))
logestic_model
#logestic_model = glm(Attrition ~ .,empdata,family=binomial(link="logit"))

summary(logestic_model)

#Predict Value
pred = predict(logestic_model,empdata,type = "response")

#pred = predict(logestic_model,train,type = "response")

#Confmatrix of model
confmatrix = table(Actual_Value=empdata$Attrition,Predicted_value = pred > 0.5)
confmatrix

#Accuracy of model
accuracy =(confmatrix[[1,1]] + confmatrix[[2,2]])/ sum(confmatrix)
print(accuracy)


#---------------------------- Random Forest ------------------------#

#install the package
library(randomForest)

# Fit the model
rtmodel = randomForest(Attrition ~ TotalWorkingYears + OverTime + YearsWithCurrManager + MonthlyIncome + YearsAtCompany,data = empdata)
rtmodel

summary(rtmodel)

#Predict Value  
pred = predict(rtmodel,empdata,type = "response")

# Confmatrix 
confmatrix = table(Actual_Value=empdata$Attrition,Predicted_value = pred)
confmatrix

#Accueacy of model
accuracy =(confmatrix[[1,1]] + confmatrix[[2,2]])/ sum(confmatrix)
print(accuracy)

#------------------------ SVM -------------------------------------#

#Install Packages

install.packages('e1071')
library(e1071)

# Fit the model
svmmodel = svm(Attrition ~ TotalWorkingYears + OverTime + YearsWithCurrManager + MonthlyIncome + YearsAtCompany,data = empdata)
svmmodel

summary(svmmodel)

#Predict Value  
pred = predict(svmmodel,empdata,type = "response")

#Confmatrix 
confmatrix = table(Actual_Value=empdata$Attrition,Predicted_value = pred)
confmatrix

#Accueacy of model
accuracy =(confmatrix[[1,1]] + confmatrix[[2,2]])/ sum(confmatrix)
print(accuracy)


#------------------------------ Naivy Bayes ------------------------#

library(e1071)

# Fit the model
nbmodel = naiveBayes(Attrition ~ TotalWorkingYears + OverTime + YearsWithCurrManager + MonthlyIncome + YearsAtCompany,data = empdata)
nbmodel

summary(nbmodel)

#Predict Value
pred = predict(nbmodel,empdata,type = "class")


#Confmatrix of model
confmatrix = table(Actual_Value=empdata$Attrition,Predicted_value = pred)
confmatrix

#Accuracy of model
accuracy =(confmatrix[[1,1]] + confmatrix[[2,2]])/ sum(confmatrix)
print(accuracy)


#---------------------- Decision Tree ------------------------------#
#rpart :- for decision tree
#rose :-  package for classification
#install.packages("ROSE")
library(ROSE)
#install.packages("rpart")
library(rpart)


# Fit the model
dtmodel = rpart(Attrition ~ TotalWorkingYears + OverTime + YearsWithCurrManager + MonthlyIncome + YearsAtCompany,data = empdata)
dtmodel

summary(dtmodel)

#Predict Value  
pred = predict(dtmodel,empdata,type = "class")

#Confmatrix 
confmatrix = table(Actual_Value=empdata$Attrition,Predicted_value = pred)
confmatrix

#Accueacy of model
accuracy =(confmatrix[[1,1]] + confmatrix[[2,2]])/ sum(confmatrix)
print(accuracy)


# In this project there best algorithm is Random Forest

