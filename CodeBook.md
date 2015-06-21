# Code Book tidyData.txt dataset.

##Data source

This raw data was sourced from the "Human Activity Recognition Using Smartphones Data Set" which was originally made avaiable here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones and downloaded for this project from  : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Description


All transformations have been documented in the R script.

Raw data is uploaded into into two files trainData for training data and testData for testing data. 

actLabels contains the activity labels. column names are corrected to make it readable and consistent. 

Trainin and testing data is merged into mergedData.

Relevant columns are isolated and aggregate data written to tidyData.txt.


