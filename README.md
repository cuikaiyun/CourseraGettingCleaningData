# Getting and Cleaning Data Course Project

## run_analysis.R

To run this script, the working directory has to be set to be the root folder of the orignal data, which is "/UCI HAR Dataset".The script run_analysis.R has to be put in the root folder "/UCI HAR Dataset". After running the script, a data file "averagedataset.txt" will be generated in the root folder "/UCI HAR Dataset", which contains a tidy data set with the average of each variable for each activity and each subject (requirement #5).

There are two major parts in the script file "run_analysis.R". The first part reads and merge the test and train data, extracts the mean and standard deviation for each measurement, and then appropriately labels the variable names (requirement #1 - #4). Please be noted that the data in the subfolders "Inertial Signals" are not used. The second part creteas a second tidy data set with the average of each variable for each activity and each subject, and then writes the data set into a txt file called "averagedataset.txt".
