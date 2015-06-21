Getting and Cleaning Data Course Project
========================================
* The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set
* I have provided the unzipped data set from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
 in the data directory of this repository
* Clone this repository to get the data files and script
* Source the run_analysis.R script
```
source("run_analysis.R")
```
* Run the script with the path to your data directory or use the default "./data/UCI HAR Dataset". If you're using Windows, you will need to specify the file path to your dataset as the default directory separators are different for your system
```
run_analysis("./data/UCI HAR Dataset")
```
* Verify the output in tidyData.txt
