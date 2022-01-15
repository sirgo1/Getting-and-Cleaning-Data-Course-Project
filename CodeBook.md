

## CODE BOOK ON HOW TO GET TO tidydata.txt
1. Download data from the link below and unzip it into working directory of R Studio.
2. Execute the R script.


# About the R script "run_analysis.R"

1. Merge the train and test datasets. To merge the train and test datasets take the following ten steps 

    (i) install "dplyr" package and load the library

    (ii) download and unzip the dataset

    (iii) load in the datasets into R

    (iv) add column names to both the xtrain and xtest data

    (v) renaming activity columns to id and actions

    (vi) row bind xtrain and xtest 

    (vii) row bind ytrain and ytest

    (viii) row bind subject train and subject test

    (ix) column bind combineY,combineX and combineSubj 

    (x) merge the above data frame with the activity

2. Extracting only the measurements on the mean and sd for each measurement

3. Use descriptive activity names

4. use descriptive activity names to name the activities in the data set

5. creates a second data set with the average of each variable for activity and subject. Text file for final output

        `tidydata.txt`  

The code assumes all the data is present in the same folder, un-compressed and without names altered.

# About variables   
* `xtrain`, `ytrain`, `xtest`, `ytest`, `subtrain`, `subtest`, `activity`, `features` contain the data from the downloaded files.

* `cmbineX`, `combineY` and `combineSubj` merge the previous datasets for further analysis.

* `df1` is the merged dataset of the test and train data

* `df2` is is the extration of the measurements on the mean and standard deviation for each measurement

* `df3` is the second data set with the average of each variable for activity and subject.

* `tidydata.txt` is the text file for final output
