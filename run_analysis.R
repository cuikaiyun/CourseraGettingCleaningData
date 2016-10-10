cleandata <- function(){
    
    ##set the working directory
    #setwd("~/DataScience_Coursera/Getting&Cleaning Data/data/UCI HAR Dataset")
    
    #################################Part 1: Combine & Clean data################################################
    ##load the subjectid and the activity label of the train and test data set respectively
    trainsubject <- fread("train/subject_train.txt")
    trainactivitylable <- fread("train/y_train.txt")
    testsubject <- fread("test/subject_test.txt")
    testactivitylable <- fread("test/y_test.txt")
    
    ##combine the subjectid and activity label data of the train and test data set
    subjectid <- rbind(trainsubject, testsubject)
    activitylabel <- rbind(trainactivitylable, testactivitylable)
    
    ##load the feature data of the train and test data set respectively
    traindata <- fread("train/X_train.txt")
    testdata <- fread("test/X_test.txt")
    
    ##combine the feature data of the train and test data set
    featuredataset <- rbind(traindata, testdata)
    
    ##combine the featuredataset with the subjectid and activitylabel
    featuredataset <- cbind(subjectid, activitylabel, featuredataset)
    
    ##load the feature names data
    features <- fread("features.txt")
    
    ##add the subjectid and activitylabel to form the column names vector
    columnnames <- c("subjectid", "activitylabel", features$V2)
    
    ##set the column names of the featuredataset
    setnames(featuredataset, columnnames)
    
    ##order the featuredataset by subjectid and activitylabel
    setkey(featuredataset, subjectid, activitylabel)
    
    ##extract only the measurements on the mean and standard deviation for each measurement
    selectcondition <- append(grep("mean\\(\\)|std\\(\\)", columnnames), 1:2, after = 0)
    selecteddataset <- featuredataset[,selectcondition, with = FALSE]
    
    ##replace the integer activity id with activity string factors
    activitystring <- fread("activity_labels.txt")
    selecteddataset$activitylabel <- as.factor(selecteddataset$activitylabel)
    levels(selecteddataset$activitylabel) <- activitystring$V2
    
    #################################Part 2: Create a new average dataset################################################
    ##load the library dplyr
    library(dplyr)
    
    ##create a second, independent tidy data set with the average of each variable for each activity and each subject
    averagedataset <- tbl_df(selecteddataset)
    averagedataset <- (averagedataset %>% group_by(subjectid, activitylabel) %>% summarise_each(funs(mean)))
    
    ##write the tidy data set into a txt file
    write.table(averagedataset, file = "averagedataset.txt", row.names = FALSE)
}