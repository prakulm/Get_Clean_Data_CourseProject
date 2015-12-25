##install.packages("reshape2")
##library(reshape2)

## Load all input data
x_train <- read.table(file = "getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\train\\X_train.txt")
y_train <- read.table(file = "getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\train\\y_train.txt")
subject_train <- read.table(file = "getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\train\\subject_train.txt")

x_test <- read.table(file = "getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\test\\X_test.txt")
y_test <- read.table(file = "getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\test\\y_test.txt")
subject_test <- read.table(file = "getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\test\\subject_test.txt")

## Combine Train and Test Data
train_combined <- cbind(subject_id = subject_train$V1,activity_label = y_train$V1, x_train)
test_combined <- cbind(subject_id = subject_test$V1,activity_label = y_test$V1, x_test)
train_test_merged <- rbind(train_combined, test_combined)

## Load Features and create clean descriptions
features <- read.table(file = "getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\features.txt")
features$V2 <- gsub("BodyBody","Body",gsub("-","_", gsub("\\(\\)","",features$V2)))

## Identify Mean and Std Variables
ptn1 = 'mean?' 
ndx1 = grep(ptn1, features$V2, perl = T)
ptn2 = 'std?'
ndx2 = grep(ptn2, features$V2, perl = T)
ndx_final <- c(ndx1,ndx2)
ndx_final <- sort(ndx_final)
features_mean_std <- features[ndx_final,]

activity <- read.table(file = "getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\activity_labels.txt")
colnames(activity) <- c("index", "activity_description")

##Pull Mean and Std variables and name the variables decriptively
train_test_merged_mean_std <- train_test_merged[c(1,2,features_mean_std$V1 +2)]
colnames(train_test_merged_mean_std) = c("subject_id","activity_label",features_mean_std$V2)

## Replace activity labels with activity descriptions
train_test_final <- merge(train_test_merged_mean_std, activity, by.x = "activity_label",by.y = "index", all = TRUE)
train_test_final <- train_test_final[,c(2,82,3:81)]

## Calculate mean of all metrics for each combination of subject Id and Activity Description
train_test_melt <- melt(train_test_final, id = c("subject_id","activity_description"), measure.vars = colnames(train_test_final)[3:81])
tidy_data <- dcast(train_test_melt, subject_id + activity_description ~ variable, mean)

## Export Tidy data file
write.table(tidy_data, file = "getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\tidy_data.txt", row.names = FALSE)
