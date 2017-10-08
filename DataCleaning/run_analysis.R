library(dplyr)
library(data.table)

##-----------------------------STEP 1: Read Data Set and combine------------------------##
#Read column/feature variable names for Dataset
columnNames <- read.table("C:\\Coursera\\3. Data Cleansing\\Week 4\\Assignment\\HAR Dataset\\UCI HAR Dataset\\features.txt")


# Read Test Data, Activity and Subject from files
testData <- read.fwf("C:\\Coursera\\3. Data Cleansing\\Week 4\\Assignment\\HAR Dataset\\UCI HAR Dataset\\test\\X_test.txt", widths = rep(16, 561))
testSubject <- read.table("C:\\Coursera\\3. Data Cleansing\\Week 4\\Assignment\\HAR Dataset\\UCI HAR Dataset\\test\\subject_test.txt")
testActivity <- read.table("C:\\Coursera\\3. Data Cleansing\\Week 4\\Assignment\\HAR Dataset\\UCI HAR Dataset\\test\\y_test.txt")

## Set feature column/variable names for Test Dataset
colnames(testData) <- columnNames[,2]
colnames(testSubject) <- c("subject")
colnames(testActivity) <- c("activityid")

##Bind Subject # as first column in Test data set
testFinalData <- cbind(testSubject, testActivity, testData)


# Read Training Data and Subject from files
trainData <- read.fwf("C:\\Coursera\\3. Data Cleansing\\Week 4\\Assignment\\HAR Dataset\\UCI HAR Dataset\\train\\X_train.txt", widths = rep(16, 561))
trainSubject <- read.table("C:\\Coursera\\3. Data Cleansing\\Week 4\\Assignment\\HAR Dataset\\UCI HAR Dataset\\train\\subject_train.txt")
trainActivity <- read.table("C:\\Coursera\\3. Data Cleansing\\Week 4\\Assignment\\HAR Dataset\\UCI HAR Dataset\\train\\y_train.txt")

## Set feature column/variable names for Training Dataset
colnames(trainData) <- columnNames[,2]
colnames(trainSubject) <- c("subject")
colnames(trainActivity) <- c("activityid")

##Bind Subject # as first column in Train data set
trainFinalData <- cbind(trainSubject, trainActivity, trainData)


# Merge Test and Training Data Sets
totalData <- rbind(trainFinalData, testFinalData)



##---------------------------STEP 2: Get Mean and Standard Deviation columns only----##
## Create table with columns having mean and standard deviation
totalData_mean_std <- totalData[,grepl("subject|activityid|mean|std",names(totalData))]


##---------------------------STEP 3: Read and Set Activity Names---------------------##
activityTable <- read.table("C:\\Coursera\\3. Data Cleansing\\Week 4\\Assignment\\HAR Dataset\\UCI HAR Dataset\\activity_labels.txt", col.names = c("activityid","activityname"))

##JOIN Activity to Dataset by Activity ID to get Activity Name
mergedData <- merge(activityTable, totalData_mean_std, by="activityid")
mergedData_tbl <- tbl_df(mergedData)
mergedData_tbl <- select(mergedData_tbl, -activityid)


##---------------------------STEP 4: Label with descriptive variable names-----------##
colnames(mergedData_tbl) <- gsub("\\(\\)","",names(mergedData_tbl))
colnames(mergedData_tbl) <- gsub("-",".",names(mergedData_tbl))
colnames(mergedData_tbl) <- gsub("BodyBody","Body",names(mergedData_tbl))


##---------------------------STEP 5: Create Independent Tidy Dataset with Average----##
tidyData <- mergedData_tbl %>% group_by(activityname, subject) %>% summarise_all(mean)
tidyData <- arrange(tidyData, activityname, subject)


