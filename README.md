### Overview

The **run_analysis.R** script aims to prepare tidy data that can be used for later analysis. The raw data was collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the [site](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) where the data was obtained. The data itself can be downloaded [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

The script runs the following steps to produce the desired tidy data:

1. Load "dplyr" library. **The script installs the library if it is not previously installed.**
2. Download the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and save it into a directory called "data". The raw data is saved in a file called "getdata-projectfiles-UCI-HAR-Dataset.zip". **The script creates the directory "data" if it doesn't exist.**
3. Read the subjects from files subject_test.txt and subject_train.txt and save them into data frames called "observationsTest" and "observationsTrain" respectively. **It isn't necessary to unzip the file.**
4. Add a variable called "set" in each data frame ("observationsTest" and "observationsTrain") to represent the set ("test"/"train") of the observations.
5. Read the activities IDs and the activities labels from the file "activity_labels.txt" and stores it in the data frame "activityLabels".
6. Read the activities IDs from the observations stored into the files y_test.txt and y_train.txt and replace the IDs for the respective activity label. Then add a variable "activity" into the data frames "observationsTest" and "observationsTrain". **Delete the data frames that were used to store the activity IDs to save RAM memory.**
7. Read the observations from the files "X_test.txt" and "X_train.txt" and label the variables with the name of the features in the file "features.txt". Then add the features variables into the data frames "observationsTest" and "observationsTrain". **Delete the data frames that were used to store the features variables to save RAM memory.**
8. Select only the measurements on the mean and standard deviation for each measurement into the data frames "observationsTest" and "observationsTrain".
9. Bind "observationsTest" and "observationTrain" data sets into a single data frame called "observationsHAR". **Delete the data frames "observationsTest" and "observationTrain" to free RAM memory.**
10. Label variables in "observationsHAR" with descriptive names.
11. Group "observationsHAR" by "activity" and "subject" and summarises **only numeric variables** using mean function into a data frame called "meanObservationsHAR".
12. Write the "meanObservationsHAR" data frame into a TXT file called "mean-observations-har.txt" inside the directory "data".


### Installation

It's not necessary to install any package to use "run_analysis.R" script. **The script install by itself if necessary.**

### Usage

It is recommended that you set the workspace the same directory as the file "run_analysis.R" will run.

#### Output

The output file is a text file called "mean-observations-har.txt". This file contains 181 lines each one with 68 variables separated by space. The first line is the label of the variables.

### License

The **run_analysis.R** script is licensed under the GPLv3 (<http://www.gnu.org/licenses/gpl.html>).