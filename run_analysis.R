library(plyr)
library(dplyr)

## run_analysis is a function that:
## 1. Takes in a data directory or uses the provided data directory from the git repository
## 2. Merges the training and the test sets to create one data set.
## 3. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 4. Uses descriptive activity names to name the activities in the data set
## 5. Appropriately labels the data set with descriptive variable names. 
## 6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
run_analysis <- function(directory = "./data/UCI HAR Dataset") {
  # Read the activities and features
  activities <- read.table(paste(directory, .Platform$file.sep, "activity_labels.txt", sep = ""), col.names = c("activityId", "activityName"))
  features <- read.table(paste(directory, .Platform$file.sep, "features.txt", sep = ""), col.names = c("featureId", "featureName"))
  
  # Load the training data using features as column names
  trainingData <- read.table(paste(directory, .Platform$file.sep, "train", .Platform$file.sep, "X_train.txt", sep = ""), col.names = features$featureName)
  trainSubjects <- read.table(paste(directory, .Platform$file.sep, "train", .Platform$file.sep, "subject_train.txt", sep = ""), col.names = c("subjectId"))
  trainActivities <- read.table(paste(directory, .Platform$file.sep, "train", .Platform$file.sep, "y_train.txt", sep = ""), col.names = c("activityId"))
  trainingData <- cbind(trainSubjects, trainActivities, trainingData)
  
  # Load the test data using features as column names
  testData <- read.table(paste(directory, .Platform$file.sep, "test", .Platform$file.sep, "X_test.txt", sep = ""), col.names = features$featureName)
  testSubjects <- read.table(paste(directory, .Platform$file.sep, "test", .Platform$file.sep, "subject_test.txt", sep = ""), col.names = c("subjectId"))
  testActivities <- read.table(paste(directory, .Platform$file.sep, "test", .Platform$file.sep, "y_test.txt", sep = ""), col.names = c("activityId"))
  testData <- cbind(testSubjects, testActivities, testData)
  
  # Merge the training and test sets into one data set that has the activity names
  allData <- rbind(trainingData, testData)
  allData <- merge(allData, activities)
  
  # Extract only the measurements on the mean and standard deviation for each measurement
  allDataExtracted <- select(allData, subjectId, activityName, contains("mean"), contains("std"))
  
  # Create a second, independent tidy data set with the average of each variable for each activity and each subject.
  tidyData <- ddply(allDataExtracted, .(subjectId, activityName), function(x) colMeans(x[,3:ncol(x)]))
  
  # Write it out to a file
  write.csv(tidyData, "tidyData.txt", row.names=FALSE)
  
  # Return the tidyData set created
  tidyData
}