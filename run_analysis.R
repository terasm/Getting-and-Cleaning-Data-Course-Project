url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "Dataset.zip")
unzip("Dataset.zip")

library(data.table)
library(dplyr)

# Merge files from train folder by columns
X_train <- tbl_df(fread('./train/X_train.txt'))
y_train <- tbl_df(fread('./train/y_train.txt'))
subject_train <- tbl_df(fread('./train/subject_train.txt'))
X_train_all <- cbind(subject_train, y_train, X_train)

# Merge files from test folder by columns
X_test <- tbl_df(fread('./test/X_test.txt'))
y_test <- tbl_df(fread('./test/y_test.txt'))
subject_test <- tbl_df(fread('./test/subject_test.txt'))
X_test_all <- cbind(subject_test, y_test, X_test)

# Creates a vector from features listed in feature.txt -file
features <- fread("features.txt")
features <- features[[2]]

# Merges X_test_all and X_train_all by rows
test_and_train <- rbind(X_test_all, X_train_all)

# Select variables that have mean or std in their names + first two variable in test_and_train data.frame
cols <- sort(c(grep("mean", features) , grep("std", features)))
columns <- c(1:2, cols + 2)
mean_and_std <- tbl_df(test_and_train[,columns])

# Creates a vector from activities listed in activity_labels.txt
activity_labels <- fread("activity_labels.txt")
activity_labels <- activity_labels[[2]]

# Give descriptive names to activities
for (i in 1:6) {
  mean_and_std$V1.1 <- sub(i, activity_labels[i], mean_and_std$V1.1)
}

# Variable names
colnames(mean_and_std)[1:2] <- c("Subject", "Activity")
colnames(mean_and_std)[3:81] <- features[cols]

# descriptive variable names
names(mean_and_std) <- tolower(names(mean_and_std))
names(mean_and_std) <- gsub("\\()", "", names(mean_and_std))
names(mean_and_std) <- gsub("-", "\\.", names(mean_and_std))
names(mean_and_std) <- gsub("^t", "time\\.", names(mean_and_std))
names(mean_and_std) <- gsub("^f", "freq\\.", names(mean_and_std))

# creates table of averages
table_of_avgs <- mean_and_std %>% group_by(subject, activity) %>% summarise_all(.fun = (avg = "mean"))
names(table_of_avgs)[3:81] <- gsub("^", "avg\\.", names(table_of_avgs)[3:81])

write.table(table_of_avgs, "table_of_avgs.txt", row.names = FALSE)



