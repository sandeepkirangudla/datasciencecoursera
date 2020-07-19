library(datasets)
data(iris)
mean(iris[iris$Species == 'virginica',]['Sepal.Length'], na.rm = T)
a <- iris[iris$Species == 'virginica',]#['Sepal.Length']
round(mean(a$Sepal.Length))
apply(X = iris[,1:4], FUN = mean, MARGIN = 2)
colMeans(iris)

library(datasets)
data(mtcars)

tapply(mtcars$mpg, mtcars$cyl, mean)
mean(mtcars$mpg, mtcars$cyl)
apply(mtcars, 2, mean)
sapply(mtcars, mean)
round(abs(sapply(split(mtcars$hp, mtcars$cyl), mean)[1] - sapply(split(mtcars$hp, mtcars$cyl), mean)[3]))
with(mtcars, tapply(mpg, cyl, mean))
mtcars[mtcars$cyl == c('4', '8'), ]$c


makeVector <- function(x = numeric()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setmean <- function(mean) m <<- mean
  getmean <- function() m
  list(set = set, get = get,
       setmean = setmean,
       getmean = getmean)
}
cachemean <- function(x, ...) {
  m <- x$getmean()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- mean(data, ...)
  x$setmean(m)
  m
}
makeVector(iris$Sepal.Length)
a <- makeVector(iris$Sepal.Length)
cachemean(a)
m <- NULL
set <- function(y) {
  x <<- y
  m <<- NULL
}
get <- function() x
setmean <- function(mean) m <<- mean
getmean <- function() m
list(set = set, get = get,
     setmean = setmean,
     getmean = getmean)
