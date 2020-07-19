pollutantmean <- function(directory, pollutant, id = 1:332){
  directory <- paste(directory, "/", sep = "")
  fl <- list.files(directory)
  final <- data.frame()
  for (i in id){
    df <- read.csv(paste(directory, fl[i], sep = ""))
    final <- rbind(df,final)
  }
  mean(final[[pollutant]], na.rm = TRUE)
}

complete <- function(directory, id = 1:332){
  directory <- paste(directory, "/", sep = "")
  fl <- list.files(directory)
  final <- data.frame()
  for (i in id){
    df <- read.csv(paste(directory, fl[i], sep = ""))
    final <- rbind(final, c(i, sum(complete.cases(df))))
  }
  colnames(final) <- c('id', 'nobs')
  final
}
corr <- function(directory, threshold = 0){
  cc <- complete(directory, id = 1:332)
  id.final <- as.matrix(cc[cc$nobs>threshold, ][1])
  directory <- paste(directory, "/", sep = "")
  fl <- list.files(directory)
  final <- data.frame()
  for (i in id.final){
    df <- read.csv(paste(directory, fl[i], sep = ""))
    df <- df[complete.cases(df),]
    #print(cor(df$nitrate, df$sulfate))
    final <- rbind(final, cor(df$nitrate, df$sulfate))
  }
  colnames(final) <- "correlation"
  return(final)
}
corr("specdata")
cr <- corr("specdata", 2000)                
n <- length(cr)                
cr <- corr("specdata", 1000)                
cr <- sort(cr$correlation)
print(c(n, round(cr, 4)))
