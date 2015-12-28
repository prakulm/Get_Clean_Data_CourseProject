##Script File Name: run_analysis.R

####Introduction-

This script performs the steps required for the "Getting and Cleaning Data" Course Project.

####Prerequisties

The analysis script expects the data to be available in the current working directory in a folder called "getdata-projectfiles-UCI HAR Dataset". This folder contains all unzipped data.


#### Approach Followed for the Analysis

Steps followed for carrying out analysis are listed below- 

1. Load all Training and Test data sets into R. This includes reading feature vectors, labels and Subject Ids
2. Combine all training data into one dataset. This means having feature vectors, labels and subject Ids in one dataset. Do the same for Test data set
3. Now combine Training and Test datasets created in Step 2 into one dataset. This is achieved by appending Test data rows below training dataset. Finally we have one dataset with all information
4. Load features lookup file. Clean the names of features. Based on names of features, identify all features related to 'mean' and standard deviation'
5. Load Activity Description file 
6. From dataset created in Step 3 select only those features which are related to 'mean' and 'standard deviation'. This is done based on identification done in Step 4
7. Descriptively name all features created in Step 6. Namaing of columns is done based on cleaned names of features from Step 4.
8. Replace activity labels with activity descriptions
9. Calculate mean of all metrics for each combination of subject Id and Activity Description. This creates final tidy data set
10. Export final tidy data file into a text file.

#### Output File: Tidy_Data.txt

File contains final results of run_analysis.R
