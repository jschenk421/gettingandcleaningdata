# Getting and cleaning data: Codebook

<ins>The raw data:</ins>
The data was obtained from: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


The actual downloaded version is:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


<ins>The processed data:</ins>
Only the observations on the **mean** and **standard deviation** were kept.

Reading the original codebook (**features_info.txt** in the dataset) one can 
argue that **freqmean** and **angle** are not mean values that we are looking 
for. They are different categories. So they are skipped.

The variables starting with **f** are also skipped because they represent 
calculated values that are calculated from the variables that start with **t**.

The variable names have only been converted to lower case. There is in my opinion
no valid conversion that can convert them into better understandable names that
obey the rules of tidyness. So I left them the way they are.


<ins>The tidy data:</ins>
The tidy data is in the file **tidy.txt** and has the average of each variable for 
each activity and each subject. That is for all 30 individuals per activity the
mean of all observations on all variables is given. Resulting in 30 times 6 = 180
mean values.

The subjects have been deidentified and are numbered 1 through 30.

The activities are:

1. WALKING  
2. WALKING_UPSTAIRS  
3. WALKING_DOWNSTAIRS  
4. SITTING  
5. STANDING  
6. LAYING  

The variables that were kept are:

1. tbodyacc-mean()-x  
1. tbodyacc-mean()-y  
1. tbodyacc-mean()-z  
1. tbodyacc-std()-x  
1. tbodyacc-std()-y  
1. tbodyacc-std()-z  
1. tbodyaccjerk-mean()-x  
1. tbodyaccjerk-mean()-y  
1. tbodyaccjerk-mean()-z  
1. tbodyaccjerk-std()-x  
1. tbodyaccjerk-std()-y  
1. tbodyaccjerk-std()-z  
1. tbodyaccjerkmag-mean()  
1. tbodyaccjerkmag-std()  
1. tbodyaccmag-mean()  
1. tbodyaccmag-std()  
1. tbodygyro-mean()-x  
1. tbodygyro-mean()-y  
1. tbodygyro-mean()-z  
1. tbodygyro-std()-x  
1. tbodygyro-std()-y  
1. tbodygyro-std()-z  
1. tbodygyrojerk-mean()-x  
1. tbodygyrojerk-mean()-y  
1. tbodygyrojerk-mean()-z  
1. tbodygyrojerk-std()-x  
1. tbodygyrojerk-std()-y  
1. tbodygyrojerk-std()-z  
1. tbodygyrojerkmag-mean()  
1. tbodygyrojerkmag-std()  
1. tbodygyromag-mean()  
1. tbodygyromag-std()  
1. tgravityacc-mean()-x  
1. tgravityacc-mean()-y  
1. tgravityacc-mean()-z  
1. tgravityacc-std()-x  
1. tgravityacc-std()-y  
1. tgravityacc-std()-z  
1. tgravityaccmag-mean()  
1. tgravityaccmag-std()  

There is no info on the units in the original dataset. So there is no info on it in the tidy set either.
