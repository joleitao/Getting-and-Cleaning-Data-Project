# Codebook for tidy_data data set as part of the Getting and Cleaning Data project

Data from the Human Activity Recognition Using Smartphones Dataset was use to create a tidy data set. For more information about this database visit this [website][1]. You can also find more information about the dataset in the README.txt and features_into.txt files.

The requirements for the transformation into a idy data set were the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Variables used in the transformation in the run_analysis.R script:

* activity_labels: contains encoding for activity labels (numeric to descriptive)
* feat_names: contains feature names that correspond to the columns in the test and training data sets
* subj_test: contains encoding for which rows in the test data set correspond to each subject
* test_labels: contains encoding for which rows in the test data set correspond to each activity (using already the descriptive names)
* test_set: data frame combining subject info, activity info and test data (with appropriate column labelling according to feat names variables)
* subj_train: contains encoding for which rows in the train data set correspond to each subject
* train_labels: contains encoding for which rows in the train data set correspond to each activity (using already the descriptive names)
* train_set: data frame combining subject info, activity info and train data (with appropriate column labelling according to feat names variables)
* data_set: combination of the above described test and train set by concatenating the rows
* ind_mean: indices determining which columns correspond to mean measurements
* ind_meanFreq: indices determining which columns correspond to meanFrew measurements
* ind_std: indices determining which columns correspond to std measurements
* ind_total: combination of indices that correspond to mean and std measurements
* data_set_extract: uses data_set and ind_total to extract only the columns pertaining to mean and std measurements. Also removes () from the feature names
* tidy_data: contains average (by subject and activity type) of the extracted columns 

The tidy_data variable is then used to write the tidyData.txt file 

[1]: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones "data base"
