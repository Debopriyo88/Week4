The run_analysis.R performs the following tasks on the raw data :

1. Reads the following files from the ‘test’ folder and creates data frames as below

	subject_test <- subject_test.txt
	X_test <- X_test.txt
	y_test <- y_test.txt

2. Reads the following files from the ‘train’ folder and creates data frames as below

	subject_train <- subject_train.txt
	X_train <- X_train.txt
	y_train <- y_train.txt

3. Merges the training and the test sets to create one data set
a. test is created by using cbind() function to bind subject_test,y_test,X_test respectively 
b. train is created by using cbind() function to bind subject_train,y_train,X_train respectively
c. merged is created by using rbind() function to merge test and train

4. Appropriately labels the data set with descriptive variable names
a. Read features.txt into data frame features
b. Select column 2 (V2) of features to get labels
c. Changes existing labels to avoid special characters like ? , _ , ( , ), etc...using gsub function
d. All start with character f in column’s name replaced by Frequency using gsub function
e. All start with character t in column’s name replaced by Time using gsub function
f. Concatenate SubjectID, ActivityName and labels-V2 to get all the column names of merged
g. Assign column names from step d to merged 

5. Extracts only the measurements on the mean and standard deviation for each measurement
a. merged_mean_std (10299 rows, 88 columns) is created by subsetting merged, selecting only columns: SubjectID, ActivityName and anything that contains the patterns “[Mm]ean” or “std”

6. Uses descriptive activity names to name the activities in the data set
a. Activity type lookup using named vector getactivitynames
b. Create merged_mean_std data frame which has the descriptive activity names in column 2

7. From the data set in step 6, creates a second, independent tidy data set with the average of each variable for each activity and each subject
a. final_data (180 rows, 88 columns) is created by summarizing merged_mean_std taking the means of each variable for each activity and each subject, after applying group_by( ) function  by subject and activity.
b. Export final_data into SubmittedData.txt file.



