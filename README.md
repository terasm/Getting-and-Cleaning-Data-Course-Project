# Getting-and-Cleaning-Data-Course-Project
This repository contains my script (run_analysis.R) and code book (CODEBOOK.md) to Coursera's Getting and Cleaning Data -course project.

Aim of the project is to merge data provided in a given url and create a tidy dataset from the given data. The final tidy dataset contains  only measurements on the mean and standard deviation for each measurement in the original data.

Code in the script (run_analysis.R) downloads files from the given url and unzips the files. Selected files from the test and train folders are merged. From the merged file only variables that contains mean and standard deviation of each measurement are chosen.

Tidying of the dataset is done by adding descriptive activity names (names provided in a separate file) to the variable which contains activities presented as numerals. Also variable names are cleaned by using lower case letters, by removing parentheses, by chancing - to . and by adding words time. or freq. to appropriate variable names.

The tidy dataset is used in getting the average values for each measurement for each subject and for each activity. Table containing the means, is provided as separate txt file ("table_of_avgs.txt")
