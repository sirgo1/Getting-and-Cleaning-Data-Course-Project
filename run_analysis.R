
# 1. Merge the training and test datasets

    #STEP(i): install "dplyr" package and load the library
            install.packages("dplyr")
            library(dplyr)

    #STEP(ii): download and unzip the dataset
            fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
            download.file(fileurl,"projectdatasets.zip")

            unzip(zipfile = "projectdatasets.zip")

    #STEP(iii): loading in the datasets into R

              #loading in the train data
              
              xtrain<-read.table('./UCI HAR Dataset/train/X_train.txt', header=FALSE)
              ytrain<-read.table('./UCI HAR Dataset/train/y_train.txt', header=FALSE)

              #loading in the test data

              xtest<-read.table('./UCI HAR Dataset/test/X_test.txt', header=FALSE)
              ytest<-read.table('./UCI HAR Dataset/test/y_test.txt', header=FALSE)

              #loading in the features data

              features<-read.table('./UCI HAR Dataset/features.txt', header=FALSE)

              #loading in the activity data

              activity<-read.table('./UCI HAR Dataset/activity_labels.txt', header=FALSE)

              #loading in the subject data and renaming column V1

              subtrain<-read.table('./UCI HAR Dataset/train/subject_train.txt', header=FALSE)
              subtrain<-subtrain %>% rename(subjectID=V1)
              subtest<-read.table('./UCI HAR Dataset/test/subject_test.txt', header=FALSE)
              subtest<-subtest %>% rename(subjectID=V1)

    #STEP(iv): adding column names to both the xtrain and xtest data

              features<-features[,2]
              featrasp<-t(features)
              colnames(xtrain)<-featrasp
              colnames(xtest)<-featrasp

    #STEP(v): renaming activity columns to id and actions

              colnames(activity)<-c('id','actions')

    #STEP(vi): row bind xtrain and xtest 
          
              combineX<-rbind(xtrain, xtest)

    #STEP(vii): row bind ytrain and ytest

              combineY<-rbind(ytrain, ytest)

    #STEP(viii): row bind subject train and subject test

              combineSubj<-rbind(subtrain,subtest)

    #STEP(ix): column bind Y and X (the two data frames created above). We then have everything except for activity 

              combineXY<-cbind(combineY,combineX, combineSubj)

    #STEP(x): merge the above data frame with the activity

              df1<-merge(combineXY, activity,by.x = 'V1',by.y = 'id')

# 2. Extracting only the measurements on the mean and sd for each measurement
              
          colNames<-colnames(df1)
          df2<-df1 %>% select(actions, subjectID, grep("\\bmean\\b|\\bstd\\b",colNames))
          df2$actions<-as.factor(df2$actions)

# 3. Use descriptive activity names
    #Answered in STEP(v) of number 1


# 4.use descriptive activity names to name the activities in the data set
        colnames(df2)<-gsub("^t", "time", colnames(df2))
        colnames(df2)<-gsub("^f", "frequency", colnames(df2))
        colnames(df2)<-gsub("Acc", "Accelerometer", colnames(df2))
        colnames(df2)<-gsub("Gyro", "Gyroscope", colnames(df2))
        colnames(df2)<-gsub("Mag", "Magnitude", colnames(df2))
        colnames(df2)<-gsub("BodyBody", "Body", colnames(df2))

# 5. creates a second data set with the average of each variable for activity and subject.
        df3<-aggregate(. ~subjectID + actions, df2, mean)

# text file for final output
        write.table(df3, file = "tidydata.txt", row.name=FALSE)
        