## 1. Extracting mean() and std()
Create a vector of only mean and std labels, then use the vector to subset dataSet.
* MeanStdOnly : a vector of only mean and std labels extracted from 2nd column of features
* dataSet : at the end of this step, dataSet will only contain mean and std variables

## 2. Reading Data and joining datasets for train and test
* testsub : subject IDs for test
* trainsub  : subject IDs for train
* test : values of variables in test
* train : values of variables in train
* testY : activity ID in test
* trainY : activity ID in train
* aclab : Description of activity IDs in testY and trainY
* fneed : description(label) of each variables in test and train
* trainfinal : bind dataset of trainsub, trainY and train
* testfinal : bind dataset of testsub, testY and test

## 3. Subset to required fields
Create a vector of "clean" feature names by getting rid of "()" at the end and expanding the short forms to give a better idea of the names. Then, we'll apply that to the dataSet to rename column labels.
* fa : a vector of "clean" feature names 

## 4. Assign column names to the data frames
Proper column names are assigned to trainfinal and testfinal using fa vector.


## 5. Combine test and training data
*combine : rbind of trainfinal and testfinal


## 6. Convert Subject and Activity to factors
Convert the values present in the columns so that the data can be grouped using them as levels.

## 6. Group data and take mean
*combinedA : Same data frame as combine but data is grouped by Subject and Activity and the mean is taken for each combination

## 6. Output tidy data
In this part, combinedA is written to a txt file using the write.table() method. Finally output the data as "tidy_data.txt"

