# Getting and cleaning data: Course project
There is only one script to run. That is **run_analysis.R**

This script assumes that you have the following files in your R workspace.  
1. activity_labels.txt  
2. features.txt  
3. subject_test.txt  
4. subject_train.txt  
5. X_test.txt  
6. X_train.txt  
7. y_test.txt  
8. y_train.txt  

You must also have the **dplyr** package installed.

The script reads the data. Keeps the data concerning **mean** and 
**standard deviation** and keeps this in memory. It then processes this 
cleaned up data to compute the average of each variable for each activity 
and each subject.

The result is then written to a directory called **data** in your workspace.
If the directory doesn't exist, it will create it.
