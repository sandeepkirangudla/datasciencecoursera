library(dplyr)
library(magrittr)
best <- function(state, outcome, best) {
  ## Read outcome data
  `%notin%` <- Negate(`%in%`)
  df <- read.csv("Mod2/Lec4/outcome-of-care-measures.csv", colClasses = "character")[,c(2, 7, 11, 17, 23)]
  valid_states <- unique(df$State)
  valid_outcome <- data.frame(id = c(3, 4, 5), value = c('heart attack', 'heart failure', 'pneumonia'), stringsAsFactors = FALSE)
  ## Check that state and outcome are valid
  if(state %notin% valid_states) stop("invalid state")
  if(outcome %notin% valid_outcome[, 2]) stop("invalid outcome")
  ## Return hospital name in that state with lowest 30-day death
  id <- valid_outcome[valid_outcome$value == outcome, ][1, 1]
  df <- df[df[["State"]] == state, ][,c(1:2,id)]
  df[, 1] <- as.character(df[, 1])
  df[, 3] <- as.numeric(df[, 3])
  df <- df[complete.cases(df), ]
  df[order(df[, 3], df[, 1]), ][best, ]
  ## rate
}
best("TX", "heart attack", 3)

rankhospital <- function(state, outcome, num = "best") {
  `%notin%` <- Negate(`%in%`)
  df <- read.csv("Mod2/Lec4/outcome-of-care-measures.csv", colClasses = "character")[,c(2, 7, 11, 17, 23)]
  valid_states <- unique(df$State)
  valid_outcome <- data.frame(id = c(3, 4, 5), value = c('heart attack', 'heart failure', 'pneumonia'), stringsAsFactors = FALSE)
  ## Check that state and outcome are valid
  if(state %notin% valid_states) stop("invalid state")
  if(outcome %notin% valid_outcome[, 2]) stop("invalid outcome")
  ## Return hospital name in that state with the given rank
  if(num == 'best'){
    best(state, outcome, 1)
    } else if(num == 'worst'){
    worst <- best(state, outcome, -1)
    tail(worst, 1)
    } else if(class(num) == "numeric") best(state, outcome, num)
  ## 30-day death rate
}

rankall <- function(outcome, num = "best") {
  `%notin%` <- Negate(`%in%`)
  df <- read.csv("Mod2/Lec4/outcome-of-care-measures.csv", colClasses = "character")[,c(2, 7, 11, 17, 23)]
  valid_outcome <- data.frame(id = c(3, 4, 5), value = c('heart attack', 'heart failure', 'pneumonia'), stringsAsFactors = FALSE)
  ## Check that state and outcome are valid
  if(outcome %notin% valid_outcome[, 2]) stop("invalid outcome")
  ## For each state, find the hospital of the given rank
  s <- split(df, df$State)
  best1 <- function (df, outcome, num, valid_outcome){
    id <- valid_outcome[valid_outcome$value == outcome, ][1, 1]
    df <- df[,c(1:2,id)]
    df[, 1] <- as.character(df[, 1])
    df[, 3] <- as.numeric(df[, 3])
    df <- df[complete.cases(df), ]
    df[order(df[, 3], df[, 1]), ][num, ]
  }
  if(num == 'best'){
    a <- lapply(X = s, FUN = best1, outcome = outcome, num = 1, valid_outcome = valid_outcome)
  }else if(num == 'worst'){
    a <- lapply(X = s, FUN = best1, outcome = outcome, num = 1, valid_outcome = valid_outcome)
    tail(worst, 1)
  } else if(class(num) == "numeric") {
    a <- lapply(X = s, FUN = best1, outcome = outcome, num = 1, valid_outcome = valid_outcome)
    }
  
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  a <- data.frame(matrix(unlist(a), nrow=length(a), byrow=T))
  colnames(a) <- c('hospital', 'state', 'value')
  return(a)
}

head(rankall("heart attack", 20),10)
best("SC", "heart attack", 1)
best("NY", "pneumonia", 1)
best("AK", "pneumonia", 1)
rankhospital("NC", "heart attack", "worst")
r <- rankall("heart attack", 4)
as.character(subset(r, state == "HI")$hospital)
r <- rankall("pneumonia", "worst")
as.character(subset(r, state == "NJ")$hospital)
r <- rankall("heart failure", 10)
as.character(subset(r, state == "NV")$hospital)
subset(r, state == "NV")
r <- rankall("pneumonia", "worst")
as.character(subset(r, state == "NJ")$hospital)
