# run_analysis.R does the following

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation 
#    for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set.
# 4. Appropriately labels the data set with descriptive variable names. 

# 5. From the data set in step 4, creates a second, independent tidy 
#    data set with the average of each variable for each activity and 
#    each subject.


library("dplyr")


################################################################################
#                                                                              #
#                                 Part 1                                       #
#                                                                              #
################################################################################


# Read training files
observations<-read.table("X_train.txt")
actions<-read.table("y_train.txt")
persons<-read.table("subject_train.txt")

# Merge training files
trainingset<-cbind(persons,actions,observations)

# Read test files
observations<-read.table("X_test.txt")
actions<-read.table("y_test.txt")
persons<-read.table("subject_test.txt")

# Merge test files
testset<-cbind(persons,actions,observations)

# Merge test set and training set
rawset<-rbind(testset,trainingset)

# Remove redundant files from memory
rm(actions); rm(observations);rm(persons);rm(testset);rm(trainingset)


################################################################################
#                                                                              #
#                                 Part 2                                       #
#                                                                              #
################################################################################

# Read the column names from the features file. They are in the second column.
features<-read.table("features.txt")
colnames<-as.vector(features[,2])

# Convert to lower case
title<-c("subject","activity",colnames)

# Set the column names
names(rawset)<-tolower(title)

# Select the columns that have mean or std in the name
# plus the action and subject columns
smallset<-rawset[,grep("subject|activity|mean|std", names(rawset)) ]

# Remove redundant files from memory
rm(title); rm(colnames);rm(features);rm(rawset)


################################################################################
#                                                                              #
#                                 Part 3                                       #
#                                                                              #
################################################################################

# Read activities
activity<-read.table("activity_labels.txt")

# Label the columns
names(activity)<-c("activity_id","activity")

# Merge activities and test data
niceset<-merge(activity,smallset,by.x="activity_id",by.y="activity")

# Remove redundant activity_id column
resultset<-select(niceset,-activity_id)

# Remove redundant files from memory
rm(activity); rm(niceset);rm(smallset)



################################################################################
#                                                                              #
#                                 Part 4                                       #
#                                                                              #
################################################################################


