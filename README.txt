==================================================
R Script: Getting and Cleaning Data Course Project
==================================================

This Github repository includes R Script for the Coursera 'Getting and Cleaning Data Course Project'.


The Github repository includes the following files:
===================================================

- 'README.txt'

- 'run_analysis.R': R-Script for creating the required data sets.

- 'codebook.txt': Codebook with explanation of all variables created by the R-Script.



Explanation how the R Script works: 
===================================


tldr:

The script merges training and test sets and creates one data set.
Descriptive labels for the variables are used and the values within the data set are named with the specific activity.
Only measurements on mean and standard deviation are extracted for each measurement.



Long version:



### Remove Global environment
Before analysis runs, the existing global environment is removed.


### Required libraries
All needed libraries are loaded (which is dplyr).


### Setting Working Directory
Working directory is set. If necessary, please change the working directory for your purposes.


### Read files
All relevant files from the Human Activity Recognition Using Smartphones Dataset are loaded.


### Naming variables in train and test data with feature information
The columns of the dataframes X_train an X_test are named with the information included in the dataframe features with the names function.


### Binding data files with subject and activity information
Two new dataframes are created: train and test.
Via the bindcols function the new data sets include information about the volunteer, activity and the measurements.


### Joining enriched data files train and test
A new dataframe is created: data
It includes information from the train and test data set.


### Enrich data with descriptive information about activity
A new dataframe is created: dataenriched
dataenriched includes the information from data.
In the next step the index columns in dataenriched and activity_labels get the column name.
Finally dataenriched gets a new column with the descriptive values of the activity via the merge function.


### Reorder data and erase Activity index
The columns in dataenriched get reordered for better readability and the activity_labels columns is erased.


### Name Columns for Volunteers and Activity
The columns in data enriched get descriptive columns names.


### Select columns with mean or standard variation features including Volunteer and activity information
A new dataframe is created: meanstd_data
Via the grepl function only columns with column names which include mean, std, volunteer oder activity are extracted to create the new variable.
This step includes all requirements from the Course Project until step 4.


### Create average data set with mean values for all mean and standard deviation Variables in the data set meanstd_data
A new dataframe is created: average_data
Using the aggregate function the mean for all measurements broken for each Volunteer and Activity is created.
