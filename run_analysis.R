## ONLY NEEDS TO BE DONE ONCE AT THE BEGINNING #################################################
# setwd("~/Documents/Coursera Course/Getting and Cleaning Data/Project/UCI HAR Dataset")
# url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download.file(url, destfile = "./dataset.zip", method = "curl")
# unzip("dataset.zip")
# Data was downloaded on Monday, 18 May 2015 
################################################################################################
setwd("~/Documents/Coursera Course/Getting and Cleaning Data/Project/UCI HAR Dataset")

# Instructions Assignment:
# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each 
#    variable for each activity and each subject.

## loading necessary packages
library(dplyr)

## General processing

# reading activity labels into a variable in order to use it give descriptive names to activitis in data set
activity_labels <- read.table("activity_labels.txt")
names(activity_labels) = c("label", "activity")

# reading feature names into variable in order to use it to name variables in test and training data sets
# replace "-" and "," charateres in the names.
feat_names_raw <- read.table("features.txt")
feat_names <- gsub("-",".", feat_names_raw$V2)
feat_names <- gsub(",",".", feat_names)


## Preparing test data frame

# read subject info for test data set and name it "sub_id"
subj_test <- read.table(paste0("test/", "subject_test.txt"))
names(subj_test) <- "sub_id"

# read label info for test data set, name it "label" and replace numeric labels with the corresponding descriptive names using
# the activity_label variable defined before
test_labels <- read.table(paste0("test/", "y_test.txt"))
names(test_labels) <- "label"
test_labels <- sapply(test_labels, function(x) x <- activity_labels$activity[x])

# read the test data set and label the columns according to the names in the file features.txt
test_set <- read.table(paste0("test/", "X_test.txt"))
names(test_set) <- feat_names

# bind subj, label and test data set into a single data frame
test_set <- cbind(subj_test, test_labels, test_set)

## Preparing training data set

# read subject info for training data set and name it sub_id
subj_train <- read.table(paste0("train/", "subject_train.txt"))
names(subj_train) <- "sub_id"

# read label info for training data set, name it label and replace numeric value with the corresponding descriptive names using
# the activity_label variable defined before
train_labels <- read.table(paste0("train/", "y_train.txt"))
names(train_labels) <- "label"
train_labels <- sapply(train_labels, function(x) x <- activity_labels$activity[x])

# read the training data set and label the columns according to the names in the file features.txt
train_set <- read.table(paste0("train/", "X_train.txt"))
names(train_set) <- feat_names

# bind subj, label and training data set into a single data frame
train_set <- cbind(subj_train, train_labels, train_set)

## Combine test and training data sets
data_set <- rbind(test_set, train_set)

## Extract relevant columns

# finding indices for "mean" columns having in mind that "meanFreq" is a different estimation 
# (grep("mean", ) will include also the second onen, so we have to exclude it)
ind_mean <- grep("mean()", names(data_set))
ind_meanFreq <- grep("meanFreq()", names(data_set))
ind_mean <- setdiff(ind_mean,ind_meanFreq)

# finding indices for "std"
ind_std <- grep("std()", names(data_set))

# combining them in a sorted array in order to have an ordered dataframe, 
# i.e. first the means of a quantity followed by the std of the same quantity, etc...
ind_total <- sort(c(ind_mean, ind_std))

# extract relevant columns from original data frame and sort the row according to sub_id just to make it "cleaner"
data_set_extract <- data_set[ , c(1:2, ind_total)]
data_set_extract <- arrange(data_set_extract, sub_id)

# now that the relevant columns were extracted, remove weird "()" from the column names (it was useful for find std)
names(data_set_extract) <- gsub("[()]","", names(data_set_extract))


# From the data set in step 4, creates a second, independent tidy data set with the average of each 
# variable for each activity and each subject.
tidy_data <- data_set_extract %>% 
        group_by(sub_id, label) %>%
        summarise_each(funs(round(mean(., na.rm = TRUE), digits = 6)))

# transform it to a data frame format
tidy_data <- as.data.frame(tidy_data)

# and use write table to write it into a .txt file
write.table(tidy_data, file = "tidyData.txt", row.name=FALSE)


