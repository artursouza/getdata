# Author: Artur Souza
# Date: Oct 25 2014
# Getting and Cleaning Data
# Course Project

Requirements:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

df : data frame that meets the requirements 1, 2, 3 and 4.
df$Activity - Activity (factor) that was performed in that sample.
df$Subject - Identifier of the subject that performed the activity.
df[3:length(df)] - mean and std variables from the original data.

df_mean: data frame that meets requirement 5.
df_mean$Activity - Activity (factor) that was performed in that sample.
df_mean$Subject - Identifier of the subject that performed the activity.
df_mean[3:length(df)] - mean of the variables in df, grouped by activity-subject.
