library(dplyr)

# set working directory
setwd("/Users/amanda/git-repo/assignment-getting-and-cleaning-data")

# load activity
activity <- read.table("data/activity_labels.txt", col.names = c("id","activity"))

# load feature
feature <- read.table("data/features.txt", col.names = c("id","feature"))

# create logic vector to for the existance of mean() and std()
feature.filtered <- grepl("mean\\(\\)|std\\(\\)",feature$feature)

# form the required feature names
feature.names <- feature[feature.filtered,]

# replace the abbreviation names with the descriptive names
v.feature.names <- feature.names$feature
v.short.pattern <- c("^t{1}","^f{1}","BodyBody","Body","Acc", 
                     "Gravity","Gyro", "Mag", "Jerk","-mean\\(\\)","-std\\(\\)")
v.descriptive.pattern <- c("Time", "Frequency","Body","Body","Accelerator", 
                     "Gravity", "Gyroscope","Magnitude", "Jerk","MeanValue", "StandardDeviation")
for (i in seq_along(v.short.pattern)) {
    v.feature.names <- sub(v.short.pattern[i], v.descriptive.pattern[i], v.feature.names)
}
feature.names$feature <- v.feature.names

# load test data
# load subject from test/subject_test.txt
test.subject <- read.table("data/test/subject_test.txt", col.names=c("subject"))

# load activity from test/y_test.txt
test.activity <- read.table("data/test/y_test.txt", col.names = c("activity"))

# load measurement data from test/X_test.txt
test.measurement <- read.table("data/test/X_test.txt")[,feature.filtered]
names(test.measurement) <- feature.names$feature

# combine subject, activity and measurement for test data set
test.data <- cbind(test.subject,test.activity,test.measurement)

# load train data
# load subject from train/subject_train.txt
train.subject <- read.table("data/train/subject_train.txt", col.names=c("subject"))

# load activity from train/y_train.txt
train.activity <- read.table("data/train/y_train.txt", col.names = c("activity"))

# load train measurement data from train/X_train.txt
train.measurement <- read.table("data/train/X_train.txt")[,feature.filtered]
names(train.measurement) <- feature.names$feature

# combine subject, activity and measurement for train data set
train.data <- cbind(train.subject,train.activity,train.measurement)

# combine test data set and train data set
complete.data <- rbind(train.data,test.data)

# use descriptive activity names to name the activities in the data set
# turn subject and activity into factor type
complete.data$activity <- factor(complete.data$activity, levels = activity[,1], labels = activity[,2])
complete.data$subject <- factor(complete.data$subject)

# create data set for the average of each variable for each activity and each subject
result.data <- complete.data %>% 
    tbl_df() %>%
    group_by(subject, activity) %>%
    summarise_each(funs(mean)) %>%
    arrange(subject, activity)

# write data to file
write.table(result.data, "result_data.txt", row.names = FALSE)
