library(xlsx); library(magrittr); library(XML); library(RCurl); library(data.table)
if(!file.exists('data')){
  dir.create('data')
}
download.file(url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv', destfile = 'data/data.csv')
df <- read.csv('data/data.csv',comment.char = "")
typeof(df$VAL)
sum(complete.cases(df[df$VAL == 24, ][['VAL']]))
unique(df$FES)
download.file(url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx', destfile = 'ngap.xlsx', mode = 'wb')
df1 <- read.xlsx('ngap.xlsx', sheetIndex = 1, colIndex = 7:15, rowIndex = 18:23)
sum(df1$Zip*df1$Ext,na.rm=T)
fileURL <- 'http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml'
xData <- getURL(fileURL)
doc <- xmlTreeParse(fileURL, useInternal = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
rootNode[[1]][[1]]
xmlApply(rootNode, xmlValue)
zipcode <- xpathSApply(rootNode, '//zipcode',xmlValue)
name <- xpathSApply(rootNode, '//name',xmlValue)
df <- data.frame(zipcode, name)
length(df[df$zipcode == 21231, ][, 1])
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv', destfile = 'data/dt.csv')
DT <- fread('data/dt.csv')
sapply(split(DT$pwgtp15, DT$SEX), mean)
DT[, mean(pwgtp15), by = SEX]
