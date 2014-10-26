# Author: Artur Souza
# Date: Oct 25 2014
# Getting and Cleaning Data
# Course Project

# Download file first. It can take a while. Uncomment if file needs to be downloaded.
# url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download.file(url, destfile=file.path(getwd(), "UCI HAR Dataset.zip"), method="curl")
# Unzip file. Uncomment if file needs to be downloaded and/or unzipped.
# unzip(file.path(getwd(), "UCI HAR Dataset.zip"))
data_folder <- file.path(getwd(), "UCI HAR Dataset")
train_folder <- file.path(data_folder, "train")
test_folder <- file.path(data_folder, "test")

# Read files, giving proper column names.
activity_labels <- read.table(file.path(data_folder, "activity_labels.txt"), col.names=c("ActivityId", "Label"))
train_subject <- read.table(file.path(train_folder, "subject_train.txt"), col.names=c("Subject"))
features <- read.table(file.path(data_folder, "features.txt"), col.names=c("FeatureId", "Feature"))
x_train <- read.table(file.path(train_folder, "X_train.txt"), colClasses=c("numeric"), col.names=features$Feature)
y_train <- read.table(file.path(train_folder, "y_train.txt"), colClasses=c("integer"), col.names="Activity")
test_subject <- read.table(file.path(test_folder, "subject_test.txt"), col.names=c("Subject"))
x_test <- read.table(file.path(test_folder, "X_test.txt"), colClasses=c("numeric"), col.names=features$Feature)
y_test <- read.table(file.path(test_folder, "y_test.txt"), colClasses=c("integer"), col.names="Activity")
# Combine test and training data frames into a single data frame. Also, extracts only mean() and std() features.
mean_and_std_only=grep("mean()|std()", features$Feature)
df <- rbind(cbind(y_train, train_subject, x_train[,mean_and_std_only]), cbind(y_test, test_subject, x_test[,mean_and_std_only]))
# Labeling activities.
df$Activity <- factor(df$Activity, levels=activity_labels$ActivityId)
levels(df$Activity) <- activity_labels$Label
# df now meets requirements 1, 2, 3 and 4

# Requirement 5: preparing mean per Activity-Subject
df_perActivity <- split(df[3:length(df)], paste(df$Activity, df$Subject, sep=","))
df_perActivity_names <- names(df_perActivity)
df_mean_activity_subject <- data.frame()
df_mean <- data.frame()
for (i in 1:length(df_perActivity)) {
  activity_subject_row <- unlist(strsplit(df_perActivity_names[i], ","))
  df_mean_activity_subject <- rbind(df_mean_activity_subject, activity_subject_row)
  df_mean_activity_subject[,1] <- as.character(df_mean_activity_subject[,1])
  df_mean_activity_subject[,2] <- as.numeric(df_mean_activity_subject[,2])
  mean_row <- apply(df_perActivity[[i]], 2, mean)
  df_mean <- rbind(df_mean, mean_row)
}
colnames(df_mean_activity_subject) <- c("Activity", "Subject")
colnames(df_mean) <- paste("mean of ", colnames(df)[3:length(df)])
df_mean <- cbind(df_mean_activity_subject, df_mean)
# df_mean now meets requirement number 5 and contains the mean per activity-subject