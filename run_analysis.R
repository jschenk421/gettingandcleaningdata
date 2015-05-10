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
# Set the column names
title<-c("subject","activity",colnames)
names(rawset)<-tolower(title)

# a. Select the columns that have mean or std in the name
#    plus the action and subject columns
# b. Angle and meanfreq are different measures. Remove them.
# c. f-type columns are derived from t-type. They are redundant and
#    can be removed
smallset<-rawset[,grep("subject|activity|mean|std", names(rawset)) ]
smallerset<-smallset[,-grep("angle|meanfreq", names(smallset)) ]
smallestset<-smallerset[,-grep("^f", names(smallerset)) ]


# Remove redundant files from memory
rm(title); rm(colnames);rm(features);rm(rawset);rm(smallset);rm(smallerset)


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
niceset<-merge(activity,smallestset,by.x="activity_id",by.y="activity")

# Remove redundant activity_id column
resultset<-select(niceset,-activity_id)

# Remove redundant files from memory
rm(activity); rm(niceset);rm(smallestset)



################################################################################
#                                                                              #
#                                 Part 4                                       #
#                                                                              #
################################################################################

# In part 2 the columnames were converted to lower case. There is in my opinion
# no valid conversion that can convert them into better understandable names 
# that obey the rules of tidyness. So I left them the way they are.


################################################################################
#                                                                              #
#                                 Part 5                                       #
#                                                                              #
################################################################################

# Create the data directory if it doesn't exist yet.
if (!file.exists("data")) {
        dir.create("data")
}

# Write the result to file
# <TBD> Write the correct file
write.table(resultset,file.path("data","tidy.txt"),row.names=FALSE)

# Remove redundant files from memory
rm(resultset)