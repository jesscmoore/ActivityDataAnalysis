# Getting and Cleaning Data - Human Activity Data

## Contents
This repository contains 2 additional files:
- CodeBook.md - document that describes the variables, data, and transformations
- run_analysis.R - code that downloads, cleans and calculates averages of the human activity data

## Course Project

The R script ```run_analysis.R``` does the following to download measurements, convert to a tidy dataset, and calculate averages of measurements of the human activity data.

It performs the following to do this:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## How to use run_analysis.R

Run ```source("run_analysis.R")``` to download and unpack the human activity data source, make it tidy, calculate averages, and write the averages to a new file ```tiny_data.txt``` in your working directory.

### Dependencies
```run_analysis.R``` depends on ```reshape2```. If not installed, it will download and install the reshape2 package.

