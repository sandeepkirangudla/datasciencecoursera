The r_analysis script does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

r_analysis downloads data from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones in working directory and unpacks it.

It reads the feature file for requrired column names and their indexes. X_train, X_test files are read after filtering only the required columns with index and then mearged with y_train, y_test and subject files.

The average of the required columns is taken and then saved as a text file.
