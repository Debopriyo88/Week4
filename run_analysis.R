library(dplyr)

#Read TEST files
#subject_test
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

#y_test
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")

#X_test
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")

#column bind to create the test data set
test <- cbind(subject_test,y_test,X_test)

#Read TRAIN files
#subject_train
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

#y_train
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")

#X_train
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")

#column bind to create the train data set
train <- cbind(subject_train,y_train,X_train)

#merging the TEST and TRAIN data sets
merged <- rbind(train,test)


#Read features.txt to get colnames
features <- read.table("./data/UCI HAR Dataset/features.txt")

labels <- select(features,V2)

#changing existing labels to avoid special characters like - , _ , ( , ), etc...
labels$V2 <- gsub("-","",labels$V2)
labels$V2 <- gsub(",","",labels$V2)
labels$V2 <- gsub("[()]","",labels$V2)
labels$V2 <- gsub("^t","Time",labels$V2)
labels$V2 <- gsub("^f","Frequency",labels$V2)

all_labels <- c("SubjectID","ActivityName",as.character(labels$V2))

#assigning labels_merged as column names of merged data set
colnames(merged) <- all_labels

#Function to subset columns based on name pattern
Subset <- function(df, pattern) {
  ind <- grepl(pattern, names(df))
  df[,ind]
}

merged_mean_std <- Subset(merged, pattern = "SubjectID|ActivityName|mean|Mean|std")

#Read activity labels
activity <- read.table("./data/UCI HAR Dataset/activity_labels.txt")


#Activity type lookup using named vectors
getactivitynames <- activity$V2
names(getactivitynames) <- activity$V1

merged_mean_std <- mutate(merged_mean_std,ActivityName = getactivitynames[merged_mean_std$ActivityName])


#From the data set in step 4, create a second,independent tidy data set 
#with the average of each variable for each activity and each subject

final_data <- merged_mean_std %>% group_by(SubjectID,ActivityName) %>% summarize_each(mean)

write.table(final_data, "./Week4/SubmittedData.txt", row.name=FALSE)

