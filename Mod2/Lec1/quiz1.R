library(magrittr)
df <- read.csv('Mod2/Lec1/quiz1_data/hw1_data.csv')
colnames(df)
head(df,2)
dim(df)
tail(df,2)
df[47,1]
is.na(df[1]) %>% sum(.,na.rm = F)
df[1] %>% mean(.,na.rm = F)
mean(df[1],na.rm = T)
typeof(df[1])
colMeans(df,na.rm = T)
df[df$Ozone>31 & df$Temp >90,] %>% colMeans(.,na.rm = T)
apply(df[df$Month==6,]['Temp'], mean)
apply(df[df$Month==6,]['Temp'],1,mean) %>% mean()
df[df$Month==5,]['Ozone'] %>% max(.,na.rm = T)
