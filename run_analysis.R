# run_analysis.R

# Wk4 Programmming Assignment - Tidying data
# 1 Merges the training and the test sets to create one data set.
# 2 Extracts only the measurements on the mean and standard deviation 
# for each measurement.
# 3 Uses descriptive activity names to name the activities in the data set
# 4 Appropriately labels the data set with descriptive variable names.
# 5 From the data set in step 4, creates a second, independent tidy data 
# set with the average of each variable for each activity and each subject.


# check if reshape2 package is installed
if (!"reshape2" %in% installed.packages()) {
  install.packages("reshape2")
}
library(reshape2)


## Data download and unzip 
# string variables for file download
fileName <- "UCIdata.zip"
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dir <- "UCI HAR Dataset"

# File download verification. If file does not exist, download to working directory.
if(!file.exists(fileName)){
  cat("Downloading data zip file...\n")
  download.file(url,fileName, mode = "wb") # Use "wb" mode for binary file downloads
}

# File unzip verification. If the directory does not exist, unzip the downloaded file.
if(!file.exists(dir)){
  cat("Unzipping data file...\n")
  unzip(fileName, files = NULL, exdir=".")
}



## Read Data
cat("Reading in data...\n")
subject_test <- read.table(paste(dir,"test/subject_test.txt", sep="/"))
subject_train <- read.table(paste(dir,"train/subject_train.txt", sep="/"))
X_test <- read.table(paste(dir,"test/X_test.txt", sep="/"))
X_train <- read.table(paste(dir,"train/X_train.txt", sep="/"))
y_test <- read.table(paste(dir,"test/y_test.txt", sep="/"))
y_train <- read.table(paste(dir,"train/y_train.txt", sep="/"))

activity_labels <- read.table(paste(dir,"activity_labels.txt", sep="/"))
features <- read.table(paste(dir,"features.txt", sep="/"))

## Analysis
# 1. Merges the training and the test sets to create one data set.
cat("\nJoining the train and test datasets...\n")
df <- rbind(X_train,X_test)


# # 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# # Create a vector of only mean and std, use the vector to subset.
cat("\nExtracting the mean and stddev of each measurement in the full dataset...\n")
MeanStdOnly <- grep("mean()|std()", features[, 2]) 
df <- df[,MeanStdOnly]


# 4. Appropriately labels the data set with descriptive activity names.
# Create vector of "Clean" mean and stddev feature names (without brackets) 
# to apply to the mean and stddev dataSet to rename columns.
cat("\nAdding column names to the dataset...\n")
CleanFeatureNames <- sapply(features[, 2], function(x) {gsub("[()]", "",x)})
names(df) <- CleanFeatureNames[MeanStdOnly]

# combine test and train of subject data and activity data, give descriptive lables
subject <- rbind(subject_train, subject_test) # Note same order as rbind on measurements data
names(subject) <- 'subject'
activity <- rbind(y_train, y_test) # Note same order as rbind on measurements data
names(activity) <- 'activity'

# Add columns with activity and subject to the mean and stddev dataset to label 
# the measurements with the activity and subject, and create the final data set.
cat("\nAdding the subject and activity codes to the dataset...\n")
df_final <- cbind(subject,activity, df) 


# 3. Uses descriptive activity names to name the activities in the data
# Group the activity column of dataSet, rename label of levels with activity_levels, 
# and apply it to data.
cat("\nReplacing activity code with activity name in the dataset...\n")
activity_group <- factor(df_final$activity)
levels(activity_group) <- activity_labels[,2]
df_final$activity <- activity_group


# 5. Creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject. (use reshape2)
# Melt data to tall skinny data and cast means. 
# Finally write the tidy data to the working directory as "tidy_data.txt"
cat("\nCalculating the mean of each measurement for each subject and activity combination in the dataset...\n")
MeltedData <- melt(df_final,(id.vars=c("subject","activity")))
AverageData <- dcast(MeltedData, subject + activity ~ variable, mean)
# Fix column names to show that it is the average of each measure for each subject and activity
names(AverageData)[-c(1:2)] <- paste("MeanOf" , names(AverageData)[-c(1:2)], sep="")
cat("Average of first 5 measures for first 10 combinations of subject and activity...\n")
print(AverageData[1:10,1:5])


# Write averages to file
cat("\nWriting average measures to file...\n")
write.table(AverageData, "tidy_data.txt", sep = ",")

