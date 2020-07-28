library(readr); library(data.table); library(tidyr); library(dplyr); library(codebook); library(labelled)
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(url, destfile = 'data.zip')
unzip("data.zip")
header <- read.table('Mod3/UCI HAR Dataset/features.txt', header = F, stringsAsFactors = F)
req_cols <- grep(paste('mean()|std()',collapse="|"), header[, 2])
# read data
df.test <- fread(file = 'Mod3/UCI HAR Dataset/test/X_test.txt', header = F, blank.lines.skip = T, stringsAsFactors = F, select = req_cols)
names(df.test) <- header[req_cols, 2]
df.test.y <- fread(file = 'Mod3/UCI HAR Dataset/test/y_test.txt', header = F, blank.lines.skip = T, stringsAsFactors = F, col.names = ('Activity_Name'))
df.test.sub <- fread(file = 'Mod3/UCI HAR Dataset/test/subject_test.txt', header = F, blank.lines.skip = T, stringsAsFactors = F, col.names = ('Subject_Name'))
df.test <- cbind(df.test.sub, df.test.y, df.test)
df.train <- fread(file = 'Mod3/UCI HAR Dataset/train/X_train.txt', header = F, blank.lines.skip = T, stringsAsFactors = F, select = req_cols)
names(df.train) <- header[req_cols, 2]
df.train.y <- fread(file = 'Mod3/UCI HAR Dataset/train/y_train.txt', header = F, blank.lines.skip = T, stringsAsFactors = F, col.names = ('Activity_Name'))
df.train.sub <- fread(file = 'Mod3/UCI HAR Dataset/train/subject_train.txt', header = F, blank.lines.skip = T, stringsAsFactors = F, col.names = ('Subject_Name'))
df.train <- cbind(df.train.sub, df.train.y, df.train)
final <- rbind(df.train, df.test)
rm('df.test', 'df.train','df.test.y', 'df.train.y', 'url', 'req_cols', 'df.test.sub', 'df.train.sub')

final.avg <- final %>% group_by(Subject_Name, Activity_Name) %>% 
  summarize_at(vars(-c(Subject_Name, Activity_Name)), mean)
write.table(final.avg, 'final.avg.txt', row.names = F)
