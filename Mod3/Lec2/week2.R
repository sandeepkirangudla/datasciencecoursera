library(httr);library(jsonlite);library(RCurl);library(XML); library(tidyr)
oauth_endpoints("github")
myapp <- oauth_app("github",
                   key = "22ee1844b4fa45548cf4",
                   secret = "016792edada7b5701e76e974e6f66c6e59b2e273"
)
sig <- sign_oauth1.0(myapp, token = '22ee1844b4fa45548cf4',
                              token_secret = '016792edada7b5701e76e974e6f66c6e59b2e273')
homeTL <- GET('https://api.github.com/users/jtleek/repos', sig)
homeTL <- content(homeTL)
js <- jsonlite::fromJSON(toJSON(homeTL))
sort(unlist(js[,'created_at']))

htmlcode
header
html1 <- data.frame