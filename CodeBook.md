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