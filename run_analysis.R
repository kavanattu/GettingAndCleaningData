# Getting and cleaning data - project code.
# Background : I created a directory to store the data files
# dir.create("./GACD/Project/", recursive=TRUE)
# extracted the zip file and copied the entire UCI HAR Dataset folder to Project folder.

# Load training data
trainData = read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE) 
# append data at new col by using ncol(trainData) ...
# we can also use ncol(trainData) + 1 instead of hard coding.
trainData[,562] = read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE) 
trainData[,563] = read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE) 
 
# Load testing Data.

testData = read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE) 
testData[,562] = read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE) 
testData[,563] = read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE) 

# Load Activity Labels.
 
actLabels = read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE) 
 
# Read features and make the feature names better suited for R with some substitutions 
features = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
# replace -mean with Mean 
features[,2] = gsub('-mean', 'Mean', features[,2]) 
# replace -std with Std.
features[,2] = gsub('-std', 'Std', features[,2]) 
# remove ()
features[,2] = gsub('[-()]', '', features[,2]) 
 
# Create a merged data set with training and testing data 
mergedData = rbind(trainData, testData) 
 
 
# Get only the columns we want ie. data on mean and std. dev. 
colIds <- grep(".*Mean.*|.*Std.*", features[,2]) 
# First reduce the features table to columns we want 
features <- features[colIds,] 

# Now add the last two columns (subject and activity) 
colIds <- c(colIds, 562, 563) 

# Update the mergedData by retaining only the columns we want. and validate.

# ncol(mergedData)  [1] 563 
# length(colIds)    [1] 88

mergedData <- mergedData[,colIds]

# ncol(mergedData) [1] 88

# nrow(features) [1] 86

# Add the column names (features) to allData  provide lables for col 87 and 88

colnames(mergedData) <- c(features$V2, "Activity", "Subject") 

# change column names to lower case.
colnames(mergedData) <- tolower(colnames(mergedData)) 

# assign activity labels to activity column.
 
currentActivity = 1 
for (currentActivityLabel in actLabels$V2) { 
    mergedData$activity <- gsub(currentActivity, currentActivityLabel, mergedData$activity) 
    currentActivity <- currentActivity + 1 
    } 
# convert activity and subject as factors

mergedData$activity <- as.factor(mergedData$activity) 
mergedData$subject <- as.factor(mergedData$subject) 
 
# extract aggregates.
tidyData = aggregate(mergedData, by=list(activity = mergedData$activity, subject=mergedData$subject), mean) 

# Remove the subject and activity column, since a mean of those has no use 
tidyData[,90] = NULL 
tidyData[,89] = NULL 

# create the output file.
write.table(tidyData, "tidyData.txt", sep="\t") 
