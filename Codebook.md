---
title: "Codebook"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Code Book
## Pre Analysis
This script will check if the data file is present in your working directory. (If not, will download and unzip the file)

## Datasets
The following datasets are in the data zip file:

subject_test : subject IDs for test

subject_train : subject IDs for train

X_test : values of variables in test

X_train : values of variables in train

y_test : activity ID in test

y_train : activity ID in train

activity_labels : Description of activity IDs in y_test and y_train

features : description(label) of each variables in X_test and X_train

dataSet : bind of X_train and X_test


1. Read data and Merge
Used read.table to read in all the datasets. Then used rbind to read in and merge the test and training measurement datasets.

df : row bind of X_train and X_test

2. Extract only mean() and std()
Create a vector of only mean and std labels, then use the vector to subset the combined measurement dataset.

MeanStdOnly : a vector of only mean and std labels extracted from 2nd column of features
df : subsetted df to only contain mean and stddev measurements


3. Changing Column label of data
Create a vector of "clean" feature names by getting rid of "()" at the end. Then, will apply that to the df to rename column labels.

CleanFeatureNames : a vector of "clean" feature names

4. Adding Subject and Activity to the df
Combine test data and train data of subject and activity, then give descriptive lables. Finally, added these columns 'subject' and 'activity' to the LHS of the measurement data df. 

subject : bind of subject_train and subject_test
activity : bind of y_train and y_test

5. Rename ID to activity name
Group the activity column of df as "activity_group", then rename each levels with 2nd column of activity_levels. Finally apply the renamed "activity_group" to df's activity column.

activity_group : factored activity column of df

6. Output tidy data
In this part, df is melted to create tidy data. It will also add "mean of"" to each column labels for better description. Finally output the data as "tidy_data.txt"

MeltedData : melted tall and skinny df
AverageData : dcast of MeltedData with the calculated mean of subject, activity pair for all measurements