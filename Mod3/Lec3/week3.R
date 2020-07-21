library(httr); library(data.table); library(jpeg); library(reshape2); library(dplyr); library(Hmisc)
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
download.file(url, destfile = 'Lec3/hdat.csv')
df <- fread('Lec3/hdat.csv')
df$agricultureLogical <- ifelse((df$ACR == 3 & df$AGS == 6),1,0)
df[which(df$agricultureLogical == 1), ]
which(df$agricultureLogical == 1)

download.file()
jp <- download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg', destfile = 'jp1.jpeg', mode = 'wb')
jp <- readJPEG(source = 'jp1.jpeg', native = T)
quantile(jp)
head(jp)
max(jp)


url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
download.file(url = url, destfile = './Lec3/q31.csv', mode = 'wb')
url1 <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
download.file(url = url1, destfile = './Lec3/q32.csv', mode = 'wb')
df1 <- fread('./Lec3/q31.csv', blank.lines.skip = T)
df2 <- fread('./Lec3/q32.csv', blank.lines.skip = T)

final <- merge(gdp, df2, by.x = "V1", by.y = "CountryCode")
final <- final[order(as.numeric(final$V2),decreasing = T), ]
final[13,]
df1[197:length(df1),  ]
final <- final[, colSums(is.na(final)) != nrow(final)]
finals <- split(as.numeric(final[, c('V2')]), final$`Income Group`)
lapply(finals,mean)
final$grp <- cut(as.numeric(final$V2), breaks = 5)
table(final$grp,final$`Income Group`)
