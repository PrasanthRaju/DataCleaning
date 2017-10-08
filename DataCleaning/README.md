### Introduction

The process of transformation of data from multiple sources to a tidy data set has been performed through a multiple steps.

## STEP 1:
The 1st step was to read the feature variable names that were stored in features.txt file into a data frame.
This will later be used to set column names for the test, training and the combination of the two datasets.
Here's the code:

columnNames <- read.table("C:\\Coursera\\3. Data Cleansing\\Week 4\\Assignment\\HAR Dataset\\UCI HAR Dataset\\features.txt")

Data for feature, subject and activity was loaded into three different data frames from X_test, subject_test and y_test files.
The code that performs this functionality is as below:

testData <- read.fwf("C:\\Coursera\\3. Data Cleansing\\Week 4\\Assignment\\HAR Dataset\\UCI HAR Dataset\\test\\X_test.txt", widths = rep(16, 561))
testSubject <- read.table("C:\\Coursera\\3. Data Cleansing\\Week 4\\Assignment\\HAR Dataset\\UCI HAR Dataset\\test\\subject_test.txt")
testActivity <- read.table("C:\\Coursera\\3. Data Cleansing\\Week 4\\Assignment\\HAR Dataset\\UCI HAR Dataset\\test\\y_test.txt")

Following this, the column names were set to feature, subject and activity data frames. For the feature data frame (testData), the column names were set 
from the 2nd column of the feature variable data frame created earlier. This 2nd column has the name of the feature variable. subject dataset column was
named "subject" and activity column was named activityid.

colnames(testData) <- columnNames[,2]
colnames(testSubject) <- c("subject")
colnames(testActivity) <- c("activityid")

Similar transformations were done for the Training Data Set

At this point, both test and training datasets were combined using the rbind functionality to get a combined dataset.

## STEP 2:
This step involved creating a data frame by retaining just the subject, activityid and all mean and standard deviation(std) variables, using the grepl function

## STEP 3:
3rd step involved reading the Activity table which had 2 columns, namely, ActivityID and ActivityName. This data frame was then merged with the combined feature data set
to get ActivityName as part of the resulting dataset. ActivityID was then removed as ActivityName was present in the resulting dataset. This was performed using the 
SELECT function, as showng below:

mergedData_tbl <- select(mergedData_tbl, -activityid)

## STEP 4:
Since the column names in the combined feature dataset had special characters, they had to be replaced or removed to make them more readable. '()' was replaced with blank ''.
Whereas, hyphen (-) was replaced with a dot (.). Additionally, some variables had the word "BodyBody" which was replaced with "Body". These were all performed by using the 
gsub function.

## STEP 5:
In the final step of this process, a tidy data set was created with the resulting set storing the average value for each of the variables, grouped by activityname and subject.
A single piped command was used to perform this operation. The result set from Step 4 was grouped first and then summarized with the use of summarise_all function for calculation
of mean for each variable. The result set was later arranged in ascending order of activityname ad subject.

tidyData <- mergedData_tbl %>% group_by(activityname, subject) %>% summarise_all(mean)
tidyData <- arrange(tidyData, activityname, subject)

