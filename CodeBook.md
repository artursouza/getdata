# Author: Artur Souza
# Date: Oct 25 2014
# Getting and Cleaning Data
# Course Project

See files under UCI HAR Dataset.

In order to clean the data set, I had to grep for variable by label, using the expression "mean()|std()".
Then I had to join activity and subject into a single string to split the data by activity-subject. Then I calculated the mean of the other variables by looping into the split result and binding the rows into df_mean. Then I also bound the activity and subject columns back into df_mean to have the final result.
