library(readr); library(data.table); library(tidyr); library(dplyr); library(codebook); library(labelled)
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(url, destfile = 'data.zip')
unzip("data.zip")
header <- read.table('Mod3/UCI HAR Dataset/features.txt', header = F, stringsAsFactors = F)
req_cols <- grep(paste('mean()|std()',collapse="|"), header[, 2])

df.test <- fread(file = 'Mod3/UCI HAR Dataset/test/X_test.txt', header = F, blank.lines.skip = T, stringsAsFactors = F, select = req_cols)
names(df.test) <- header[req_cols, 2]
df.test.y <- fread(file = 'Mod3/UCI HAR Dataset/test/y_test.txt', header = F, blank.lines.skip = T, stringsAsFactors = F)
df.test <- cbind(df.test, df.test.y)
df.train <- fread(file = 'Mod3/UCI HAR Dataset/train/X_train.txt', header = F, blank.lines.skip = T, stringsAsFactors = F, select = req_cols)
names(df.train) <- header[req_cols, 2]
df.train.y <- fread(file = 'Mod3/UCI HAR Dataset/train/y_train.txt', header = F, blank.lines.skip = T, stringsAsFactors = F)
df.train <- cbind(df.train, df.train.y)
final <- rbind(df.train, df.test)
rm('df.test', 'df.train','df.test.y', 'df.train.y', 'url', 'req_cols')

final.avg <- final %>% group_by(V1) %>% summarize_at(vars(-V1), mean)
act.names <- fread('Mod3/UCI HAR Dataset/activity_labels.txt', header = F, blank.lines.skip = T, stringsAsFactors = F)
names(act.names) <- c('V1', 'Activity Name')
final.avg <- merge(act.names, final.avg, by = 'V1')
final.avg <- final.avg[ ,2:length(final.avg)]
