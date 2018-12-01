##########################################################
### R Script: Getting and Cleaning Data Course Project ###
##########################################################

# The following script merges training and test sets and creates one data set.
# Descriptive labels for the variables are used and the values within the
# data set are named with the specific activity.
# Only measurements on mean and standard deviation are extracted for each
# measurement.


### Remove Global environment

rm(list=ls())


### Required libraries

library(dplyr)


### Setting Working Directory

setwd("C:/UCI HAR Dataset/") # change working directory if necessary


### Read files

features <- read.table("./features.txt")
activity_labels <- read.table("./activity_labels.txt")

X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")

X_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")



### Naming variables in train and test data with feature information

names(X_train) <- features$V2
names(X_test) <- features$V2


### Binding data files with subject and activity information

train <- bind_cols(subject_train, y_train, X_train)
test <- bind_cols(subject_test ,y_test, X_test)


### Joining enriched data files train and test

data <- bind_rows(train, test)


### Enrich data with descriptive information about activity

dataenriched <- data

colnames(dataenriched)[2] <- "Activity_index"
colnames(activity_labels)[1] <- "Activity_index"
dataenriched <- merge(dataenriched, activity_labels, by = "Activity_index")


### Reorder data and erase Activity index

dataenriched <- dataenriched[,c(1,2,564,3:563)]
dataenriched <- dataenriched[,c(2:564)]


### Name Columns for Volunteers and Activity

colnames(dataenriched)[1] <- "Volunteer"
colnames(dataenriched)[2] <- "Activity"


### Select columns with mean or standard variation features invluding
### Volunteer and activity information


meanstd_data <- dataenriched[ ,grepl( "mean|std|Volunteer|Activity", names(dataenriched))]


### Create average data set with mean values for all mean and standard deviation
### variables in the data set meanstd_data

average_data <- aggregate(meanstd_data[, 3:81],
                          list(meanstd_data$Activity,meanstd_data$Volunteer),
                          mean)
colnames(average_data)[2] <- "Volunteer"
colnames(average_data)[1] <- "Activity"

write.table(average_data, file = "averagedata.txt", row.name=FALSE)
