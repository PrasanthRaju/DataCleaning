### Code Book
## Variable Names
1. columnNames:
	- Data Frame
	- List of 561 feature variables or column names from features.txt file.
2. testData:
	- Data Frame
	- Table of feature variables and their corresponding values from test dataset read from X_test.txt file.
3. testSubject:
	- Data Frame
	- Table of the list of values for subject for each row in testData
4. testActivity:
	- Data Frame
	- Table of the list of Activity IDs for each row in testData
5. testFinalData:
	- Data Frame
	- Horizontally joined result test dataset which includes activityid, subject and all variables from the test dataset (testData)
6. trainData:
	- Data Frame
	- Table of feature variables and their corresponding values from training dataset read from X_train.txt file.
7. trainSubject:
	- Data Frame
	- Table of the list of values for subject for each row in trainData
8. trainActivity:
	- Data Frame
	- Table of the list of Activity IDs for each row in trainData
9. trainFinalData:
	- Data Frame
	- Horizontally joined result training dataset which includes activityid, subject and all variables from the training dataset (trainData)
10. totalData:
	- Data Frame
	- Vertically joined data from both Training and Test Data sets
11. totalData_mean_std:
	- Data Frame
	- Dataset with only Subject, Activity and all mean and standard deviation variables
12. activityTable:
	- Data Frame
	- List of 6 activities and their corresponding IDs
13. mergedData:
	- Data Frame
	- Result Set of joining the Activity Table to the combined result of training and test dataset
14. mergedData_tbl:
	- Table Data Frame
	- Table data frame version of mergedData to be able to apply the functions like SELECT, MUTATE, SUMMARISE, etc.
	- ActivityID variable is removed from this dataset. Instead has activityname.
15. tidyData:
	- Table Data Frame
	- Grouped dataset by activity name and subject, which is summarized to calculate and store average for each variable in the total dataset
	- Data set with mean and standard deviation values are grouped first and then summarized using just one line of command