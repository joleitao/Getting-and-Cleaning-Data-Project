## README for UCI HAR Dataset repo

This repo is part of the project for the Getting and Cleaning Data Course from Coursera. The aim of the project was to take data from a dataset on the web and transform it into a tidy data set following certain requirements.  

This repo thus contains data from the Human Activity Recognition Using Smartphones Dataset, which you can find [here][1].  
The files included in the data set are:

* activity_labels.txt
* features_info.txt
* features.txt
* test folder (and everything it contains)
* train folder (and everything it contains)

For more information about the database visit this [website][2].  

The repo also includes the following files:

1. CodeBook.md: explains all the transformations done to the data in order to get a tidy data set
2. run_analysis.R: this script takes data contained in the UCI HAR Dataset folder and transforms it into a tidy data set by:
 * taking activity labels form the activity_labels.txt file
 * taking feature names from the "features.txt" file
 * combining all the relevant test data (subj id, activity label, and data itself) into a single data frame, while at the same time using the info from the two bullets above to label the activity in a descriptive way and attribute names to the different data columns
 * does the same for the training data set
 * combines both data sets by concatenating the rows together
 * keeps from this new data set only the features that pertain to mean and std measurements
 * averages each of the remaining features columns by subject and activity type
 * writes the obtained tidy data frame into a .txt file
3. tidyData.txt: the obtained tidy data set. You can read it into a variable in R by typing read.table("tidyData.txt")




[1]: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  "Data"
[2]: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones "data base"
