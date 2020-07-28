r_analysis download data from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones in working directory and unpacks it.

It reads the feature file for requrired column names and their indexes. X_train, X_test files are read after filtering only the required columns are read with index and then mearged with y_train, y_test files.

The average of the required columns is taken and then saved as a text file.
