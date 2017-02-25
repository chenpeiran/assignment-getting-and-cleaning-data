# README

## Purpose
This repository is used for the assignment submission of Getting and Cleaning Data

## Files
- run_analysis.R
- result_data.txt
- README.md
- CodeBook.md

## run_analysis.R
The R script run_analysis.R does the following steps,
* 1. Load the subject and activity information.
* 2. Load subject and activity data for test and training.
* 3. Load measurement data for each dataset, only keep the required variables/columns for mean and standard deviation.
* 4. Merge data with subject, activity and measurement.
* 5. Merge test and training datasets.
* 6. Change the variable/column name from abbreviation to descriptive names
* 7. Convert 'subject' and 'activity' to factors.
* 8. Create a new data set for the average of each variable for each activity and each subject.
* 9. Save the result in the file 'result_data.txt'

## Code Book
Code Book is in file 'CodeBook.md'
