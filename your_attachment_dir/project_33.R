## Malaria Dataset

setwd("D:/Data Science/R Project/Project3")
library(csvread)
malaria=read.csv("R_ML_Project_3_Malar.csv")
View(malaria)

names(malaria)

sum(is.na(malaria))


## Data Cleaning
library(dplyr)
# 1. Filter the Gujarat, Rajasthan and Maharashtra in state.
df_fil1=filter(malaria,malaria$State %in% c('Gujarat','Maharashtra','Rajasthan'))
View(df_fil1)

# 2. Select the data where mortality is high and very high.
df_fil2=filter(malaria,malaria$rate %in% c('High','Very High'))
View(df_fil2)

# 3. Handle the missing values in mortality rate column.
malaria=na.omit(malaria)

# 4. Rename the mortality column to mortality_category.
colnames(malaria)[9] = "Mortality_Category"
View(malaria)

## Algorithms. (Use Complete Data)

#cheak Baisc Info
names(malaria)
nrow(malaria)
ncol(malaria)

library(FSelector)
gain = gain.ratio(Mortality_Category~., malaria) 
View(gain)




# 1. Classification on mortality column.


unique(df[9])

malaria$Mortality_Category = ifelse(malaria$Mortality_Category=="Extremely high" ,5,
                                ifelse(malaria$Mortality_Category == "Very High",4,
                                       ifelse(malaria$Mortality_Category == "High",3,
                                               ifelse(malaria$Mortality_Category == "Medium",2,
                                                      ifelse(malaria$Mortality_Category == "Very Low",1,0)
                                               )
                                       )
                                )
)

malaria$Mortality_Category=as.factor(malaria$Mortality_Category)
library(caTools)
# Splitting dataset
split = sample.split(malaria$Mortality_Category, SplitRatio = 0.8)
split
train_reg = subset(malaria, split == "TRUE")
test_reg = subset(malaria, split == "FALSE")


dim(train_reg)
dim(test_reg)


#-------------------------Random Forest----------------------------#

library(randomForest)
rfmodel = randomForest(Mortality_Category ~ Mortality_rate + Category_deaths + Number_of_Malaria_incidences + State + Population,data= train_reg)
# View the forest results.
print(rfmodel)
summary(rfmodel)


#Check Accuracy of Model on Train DataSet
pred = predict(rfmodel,train_reg,type = "response")

confmatrix = table(Actual_Value=train_reg$Mortality_Category,Predicted_value = pred)
confmatrix

accuracy= (confmatrix[[1,1]] + confmatrix[[2,2]] + confmatrix[[3,3]] + confmatrix[[4,4]] + confmatrix[[5,5]] + confmatrix[[6,6]] )  / sum(confmatrix)
cat("Accuracy:",accuracy)



#Apply Model on Test DataSet
pred = predict(rfmodel,test_reg,type = "response")

confmatrix = table(Actual_Value=test_reg$Mortality_Category,Predicted_value = pred)
confmatrix

accuracy= (confmatrix[[1,1]] + confmatrix[[2,2]] + confmatrix[[3,3]] + confmatrix[[4,4]] + confmatrix[[5,5]] + confmatrix[[6,6]] )  / sum(confmatrix)
cat("Accuracy:",accuracy)


#-------------------------svm Forest----------------------------#

library(e1071)
svmmodel = svm(Mortality_Category ~ Mortality_rate + Category_deaths + Number_of_Malaria_incidences + State + Population,data= train_reg)
# View the forest results.
print(svmmodel)
summary(svmmodel)


#Check Accuracy of Model on Train DataSet
pred = predict(svmmodel,train_reg,type = "response")

confmatrix = table(Actual_Value=train_reg$Mortality_Category,Predicted_value = pred)
confmatrix

accuracy_train= (confmatrix[[1,1]] + confmatrix[[2,2]] + confmatrix[[3,3]] + confmatrix[[4,4]] + confmatrix[[5,5]] + confmatrix[[6,6]] )  / sum(confmatrix)
cat("Accuracy:",accuracy_train)



#Apply Model on Test DataSet
pred = predict(svmmodel,test_reg,type ="response")

confmatrix = table(Actual_Value=test_reg$Mortality_Category,Predicted_value = pred)
confmatrix

accuracy_test= (confmatrix[[1,1]] + confmatrix[[2,2]] + confmatrix[[3,3]] + confmatrix[[4,4]] + confmatrix[[5,5]] + confmatrix[[6,6]] )  / sum(confmatrix)
cat("Accuracy:",accuracy)

#-------------------------Naivy Bayes----------------------------#

library(e1071)
nbmodel = naiveBayes(Mortality_Category ~ Mortality_rate + Category_deaths + Number_of_Malaria_incidences + State + Population,data= train_reg)
# View the forest results.
print(nbmodel)
summary(nbmodel)


#Check Accuracy of Model on Train DataSet
pred = predict(nbmodel,train_reg,type = "class")

confmatrix = table(Actual_Value=train_reg$Mortality_Category,Predicted_value = pred)
confmatrix

accuracy= (confmatrix[[1,1]] + confmatrix[[2,2]] + confmatrix[[3,3]] + confmatrix[[4,4]] + confmatrix[[5,5]] + confmatrix[[6,6]] )  / sum(confmatrix)
cat("Accuracy:",accuracy)



#Apply Model on Test DataSet
pred = predict(nbmodel,test_reg,type = "class")

confmatrix = table(Actual_Value=test_reg$Mortality_Category,Predicted_value = pred)
confmatrix

accuracy= (confmatrix[[1,1]] + confmatrix[[2,2]] + confmatrix[[3,3]] + confmatrix[[4,4]] + confmatrix[[5,5]] + confmatrix[[6,6]] )  / sum(confmatrix)
cat("Accuracy:",accuracy)

#-------------------------Decision Tree----------------------------#

library(ROSE)
library(rpart)
dtmodel = rpart(Mortality_Category ~ Mortality_rate + Category_deaths + Number_of_Malaria_incidences + State + Population,data= train_reg)
# View the forest results.
print(dtmodel)
summary(dtmodel)


#Check Accuracy of Model on Train DataSet
pred = predict(dtmodel,train_reg,type = "response")

confmatrix = table(Actual_Value=train_reg$Mortality_Category,Predicted_value = pred)
confmatrix

accuracy= (confmatrix[[1,1]] + confmatrix[[2,2]] + confmatrix[[3,3]] + confmatrix[[4,4]] + confmatrix[[5,5]] + confmatrix[[6,6]] )  / sum(confmatrix)
cat("Accuracy:",accuracy)



#Apply Model on Test DataSet
pred = predict(dtmodel,test_reg,type = "response")

confmatrix = table(Actual_Value=test_reg$Mortality_Category,Predicted_value = pred)
confmatrix

accuracy= (confmatrix[[1,1]] + confmatrix[[2,2]] + confmatrix[[3,3]] + confmatrix[[4,4]] + confmatrix[[5,5]] + confmatrix[[6,6]] )  / sum(confmatrix)
cat("Accuracy:",accuracy)


#2. Regression on mortality_rate. (drop the mortality column).


setwd("D:/Data Science/R Project/Project3")
library(csvread)
mal=read.csv("R_ML_Project_3_Malar.csv")
View(mal)

names(mal)

sum(is.na(mal))

#handal missing value
mal=na.omit(malaria)

#drope mortality column
mal$rate=mal$rate.null
View(mal)

#------------------------ Linear Regression------------------------------------#

#fit model on dataset

lrmodel=lm(Mortality_rate ~ Category_deaths + Number_of_Malaria_incidences + State + Population ,data=mal)
print(lrmodel)
summary(lrmodel)

plot(mal$Mortality_rate,col="blue")
abline(lrmodel,col="red")

#prediction
td=data.frame(Category_deaths="Medium",Number_of_Malaria_incidences=196,State="Puducherry",Population=1244644) #5
pred = predict(lrmodel, td)
pred

td=data.frame(Category_deaths="High",Number_of_Malaria_incidences=89764,State="Gujarat",Population=60383628) #4
pred = predict(lrmodel, td)
pred

#-------------------------- select all data -----------------------------#

#fit model on dataset

lrmodel=lm(Mortality_rate ~.,data=mal)
print(lrmodel)
summary(lrmodel)

plot(mal$Mortality_rate,col="blue")
abline(lrmodel,col="red")

#--------------------- convert in to int ----------------------------#

mal$Mortality_rate=as.integer(mal$Mortality_rate)

View(mal)

#fit model on dataset

lrmodel=lm(Mortality_rate ~ Category_deaths + Number_of_Malaria_incidences + State + Population ,data=mal)
print(lrmodel)
summary(lrmodel)

plot(mal$Mortality_rate,col="blue")
abline(lrmodel,col="red")
