# This code was created to get, clean and tidy the raw data colected as part of the research "Human Activity Recognition Using Smartphones Data Set".
# Code developed by Vinicios Pereira.


# Loading libraries.

# Tests if dplyr package is installed. If not installs and loads it.
if(!library(dplyr, logical.return = TRUE)){
     install.packages("dplyr")
     library(dplyr)
}


# Downloading the data.

# Checks if data direcotry exists, if not creates it.
if(!file.exists("./data")){dir.create("./data")}
# Assigns the URL of the collection data to a variable.
dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# Downloads the data to data dorectory.
download.file(dataUrl, "./data/getdata-projectfiles-UCI-HAR-Dataset.zip", method = "curl")
# Store the date when the file was downloaded.
dateDownloaded <- date()


# Reading the subjects.

# Reads the file "subject_test.txt" inside the file "getdata-projectfiles-UCI-HAR-Dataset.zip".
zipFilePath <- "./data/getdata-projectfiles-UCI-HAR-Dataset.zip"
subjectFileTxtPath <- "UCI HAR Dataset/test/subject_test.txt"
observationsTest <- read.table(unz(zipFilePath, subjectFileTxtPath), col.names = c("subject"))

# Reads the file "subject_train.txt" inside the file "getdata-projectfiles-UCI-HAR-Dataset.zip".
subjectFileTxtPath <- "UCI HAR Dataset/train/subject_train.txt"
observationsTrain <- read.table(unz(zipFilePath, subjectFileTxtPath), col.names = c("subject"))


# Adding a variable to represent the set (test/train) of the observations.

# Adds a variable "set" in the dataset "observationsTest" with value "test" for all observations.
observationsTest <- mutate(observationsTest, set = "test")
# Adds a variable "set" in the dataset "observationsTrain" with value "train" for all observations.
observationsTrain <- mutate(observationsTrain, set = "train")


# Adding a variable to represent the lable of the activity in the observations.

# Reads the file "activity_labels.txt" inside the file "getdata-projectfiles-UCI-HAR-Dataset.zip".
activityLabelsFileTxtPath <- "UCI HAR Dataset/activity_labels.txt"
activityLabels <- read.table(unz(zipFilePath, activityLabelsFileTxtPath), col.names = c("activityId", "activity"))

# Formats activity labels to lower case.
activityLabels <- mutate(activityLabels, activity = tolower(activity))

# Reads the file "y_test.txt" inside the file "getdata-projectfiles-UCI-HAR-Dataset.zip".
ytestFileTxtPath <- "UCI HAR Dataset/test/y_test.txt"
yTest <- read.table(unz(zipFilePath, ytestFileTxtPath), col.names = c("activityId"))

# Adds the activity label in "yTest".
yTest <- mutate(yTest, activity = activityLabels$activity[activityId])

# Adds a variable with the activity label in "observationsTest".
observationsTest <- mutate(observationsTest, activity = yTest$activity)

# Deletes "yTest" data set to free memory.
rm(yTest)

# Reads the file "y_train.txt" inside the file "getdata-projectfiles-UCI-HAR-Dataset.zip".
ytrainFileTxtPath <- "UCI HAR Dataset/train/y_train.txt"
yTrain <- read.table(unz(zipFilePath, ytrainFileTxtPath), col.names = c("activityId"))

# Adds the activity label in "yTrain".
yTrain <- mutate(yTrain, activity = activityLabels$activity[activityId])

# Adds a variable with the activity label in "observationsTrain".
observationsTrain <- mutate(observationsTrain, activity = yTrain$activity)

# Deletes "yTrain" data set to free memory.
rm(yTrain)


# Adding the features into observations data sets.

# Reads the file "features.txt" inside the file "getdata-projectfiles-UCI-HAR-Dataset.zip".
featuresFileTxtPath <- "UCI HAR Dataset/features.txt"
features <- read.table(unz(zipFilePath, featuresFileTxtPath), col.names = c("featuresId", "features"))

# Reads the file "X_test.txt" inside the file "getdata-projectfiles-UCI-HAR-Dataset.zip".
xtestFileTxtPath <- "UCI HAR Dataset/test/X_test.txt"
xTest <- read.table(unz(zipFilePath, xtestFileTxtPath), col.names = features$features)

# Extracts only the measurements on the mean and standard deviation for each measurement.
xTest <- select(xTest, matches("mean\\.\\.|std\\.\\.", ignore.case = FALSE))

# Adds the features variables in "observationsTest".
observationsTest <- cbind(observationsTest, xTest)

# Deletes "xTest" data set to free memory.
rm(xTest)

# Reads the file "X_train.txt" inside the file "getdata-projectfiles-UCI-HAR-Dataset.zip".
xtrainFileTxtPath <- "UCI HAR Dataset/train/X_train.txt"
xTrain <- read.table(unz(zipFilePath, xtrainFileTxtPath), col.names = features$features)

# Extracts only the measurements on the mean and standard deviation for each measurement.
xTrain <- select(xTrain, matches("mean\\.\\.|std\\.\\.", ignore.case = FALSE))

# Adds the features variables in "observationsTrain".
observationsTrain <- cbind(observationsTrain, xTrain)

# Deletes "xTrain" data set to free memory.
rm(xTrain)


# Binding "observationsTest" and "observationTrain" data sets into a single data set.

# Binds "observationsTest" and "observationTrain" data sets into "observationsHAR".
observationsHAR <- rbind(observationsTest, observationsTrain)

# Deletes "observationsTest" to free memory.
rm(observationsTest)

# Deletes "observationsTrain" to free memory.
rm(observationsTrain)


# Labelling variables with descriptive names.

# Replaces "t" with "time" into variables names.
names(observationsHAR) <- sub("^t", "time", names(observationsHAR))

# Replaces "f" with "frequency" into variables names.
names(observationsHAR) <- sub("^f", "frequency", names(observationsHAR))

# Replaces "Acc" with "Accelerometer" into variables names.
names(observationsHAR) <- sub("Acc", "Accelerometer", names(observationsHAR), ignore.case = FALSE)

# Replaces ".mean" with "Mean" into variables names.
names(observationsHAR) <- sub("\\.mean", "Mean", names(observationsHAR), ignore.case = FALSE)

# Replaces ".std" with "Std" into variables names.
names(observationsHAR) <- sub("\\.std", "Std", names(observationsHAR), ignore.case = FALSE)

# Replaces "." with "" into variables names.
names(observationsHAR) <- gsub("\\.", "", names(observationsHAR), ignore.case = FALSE)

# Replaces "Gyro" with "Gyroscope" into variables names.
names(observationsHAR) <- sub("Gyro", "Gyroscope", names(observationsHAR), ignore.case = FALSE)

# Replaces "Mag" with "Magnitude" into variables names.
names(observationsHAR) <- sub("Mag", "Magnitude", names(observationsHAR), ignore.case = FALSE)


# Creating a second, independent tidy data set with the average of each variable for each activity and each subject.

# Groups "observationsHAR" by activity and subject.
observationsHAR <- group_by(observationsHAR, activity, subject)

# Summarises "observationsHAR" only if the variable is numeric.
meanObservationsHAR <- summarise_if(observationsHAR, is.numeric, funs(mean), na.rm = TRUE)


# Writing the meanObservationsHAR data set into a TXT file.
write.table(meanObservationsHAR, file = "./data/mean-observations-har.txt", row.names = FALSE)

