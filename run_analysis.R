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

# Remove redundant objects from memory
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


# Remove redundant objects from memory
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

# Remove redundant objects from memory
rm(activity); rm(niceset);rm(smallestset)



################################################################################
#                                                                              #
#                                 Part 4                                       #
#                                                                              #
################################################################################

# In part 2 the columnames were converted to lower case. There is in my opinion
# no valid conversion that can convert them into better understandable names 
# that obey the rules of tidyness. So I left them the way they are. However
# in case the colnames have to be referred to, they must be renamed because 
# R can not handle the reserved word mean and the minus sign in the name.


################################################################################
#                                                                              #
#                                 Part 5                                       #
#                                                                              #
################################################################################

# Create the data directory if it doesn't exist yet.
if (!file.exists("data")) {
        dir.create("data")
}


# Subset the matrix with the observations. That way we can use rowMeans.
matr<-as.matrix(resultset[,3:42])
rowmeans<-rowMeans(matr)

# Add the rowmeans to the full dataframe
extendedresultset <- cbind(resultset,rowmeans)

#Group by and summarize
extendedresultset<-group_by(extendedresultset,subject,activity)
finalresult<-summarize(extendedresultset,value=mean(rowmeans))

# Write the result to file
write.table(finalresult,file.path("data","tidy.txt"),row.names=FALSE)

# Remove redundant objects from memory
rm(resultset);rm(extendedresultset);rm(matr);rm(rowmeans);rm(finalresult)