## R Project :: Credit Card Defaulter Analysis

## Credit Card Defaulters
## Missing Value Handling and Data Subsetting

#Load dataset
# check current directory
getwd()

# set working directory
setwd("D:/Data Science/R Project/Project1")


library(csvread)
df=read.csv("R_ML_Project_1_Credi.csv")
View(df)

# 1. Replace missing value with mean.

names(df)
#check null values
lapply(df,function(df) { length(which(is.na(df)))})

df$BILL_AMT1[is.na(df$BILL_AMT1)]= mean(df$BILL_AMT1,na.rm=TRUE)
df$BILL_AMT2[is.na(df$BILL_AMT2)]= mean(df$BILL_AMT2,na.rm=TRUE)
df$BILL_AMT3[is.na(df$BILL_AMT3)]= mean(df$BILL_AMT3,na.rm=TRUE)
df$BILL_AMT4[is.na(df$BILL_AMT4)]= mean(df$BILL_AMT4,na.rm=TRUE)
df$BILL_AMT5[is.na(df$BILL_AMT5)]= mean(df$BILL_AMT5,na.rm=TRUE)
df$BILL_AMT6[is.na(df$BILL_AMT6)]= mean(df$BILL_AMT6,na.rm=TRUE)

df$PAY_AMT1[is.na(df$PAY_AMT1)]<-mean(df$PAY_AMT1,na.rm=TRUE)
df$PAY_AMT2[is.na(df$PAY_AMT2)]<-mean(df$PAY_AMT2,na.rm=TRUE)
df$PAY_AMT3[is.na(df$PAY_AMT3)]<-mean(df$PAY_AMT3,na.rm=TRUE)
df$PAY_AMT4[is.na(df$PAY_AMT4)]<-mean(df$PAY_AMT4,na.rm=TRUE)
df$PAY_AMT5[is.na(df$PAY_AMT5)]<-mean(df$PAY_AMT5,na.rm=TRUE)
df$PAY_AMT6[is.na(df$PAY_AMT6)]<-mean(df$PAY_AMT6,na.rm=TRUE)

#for (i in names(df)) {
#  df$i[is.na(df$i)]<-mean(df$i,na.rm=TRUE)}

# 2. Drop default status column. (Last one)
df$Default.Status = NULL
View(df)

# 3. Select top 2000 rows.
View(head(df,2000))

# 4. Select this column LIMIT_BAL, AGE, BILL_AMT1, PAY_AMT1
attach(df)
#without dplyer
df[,c('LIMIT_BAL','AGE', 'BILL_AMT1', 'PAY_AMT1')]

install.packages("dplyr")

library(dplyr)
View(select(df,LIMIT_BAL, AGE, BILL_AMT1, PAY_AMT1))


# 5. Select those data only who has , BILL_AMT1 more then 50000.
View(select(df)%>% filter(BILL_AMT1 > 50000))

# 6. Check the correlation on BILL_AMT1 vs PAY_AMT1.
CR=cor(BILL_AMT1,PAY_AMT1)
CR

if(CR < 0.5){
  print("There is strong positive correlation between")
}else if(CR < -0.5){
  print("There is strong negative correlation between")
}

# 7. Rename the column BILL_AMT1 as Bill_amount and PAY_AMT1 as pay_amount.
newdf=df
View(newdf)
colnames(newdf)[4] = "Bill_amount"
colnames(newdf)[10] = "pay_amount"
View(newdf)

