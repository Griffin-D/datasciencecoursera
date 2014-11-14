# getting and cleaning data quiz2

# Question1
library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications;
#    Use any URL you would like for the homepage URL (http://github.com is fine)
#    and http://localhost:1410 as the callback url
#
#    Insert your client ID and secret below - if secret is omitted, it will
#    look it up in the GITHUB_CONSUMER_SECRET environmental variable.
myapp <- oauth_app("GettingDataQuiz2", "a5bfc74a374aba64898d", secret = "")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
req <- GET("https://api.github.com/users/jtleek/repos", config(token = github_token))
stop_for_status(req)
output <- content(req)
list(output[[5]]$name, output[[5]]$created_at)

# Question 2
# The sqldf package allows for execution of SQL commands on R data frames. We will use the sqldf package to  practice the queries we might send with the dbSendQuery command in RMySQL. Download the American Community Survey data and load it into an R object called acs


# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv 

# Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?
require(sqldf)
require(tcltk)
require(data.table)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
file <- file.path(getwd(), "ss06pid.csv")
download.file(url, file)
acs <- data.table(read.csv(file))
agep_query <- sqldf("select pwgtp1 from acs where AGEP < 50")
head(agep_query)

# "select pwgtp1 from acs where AGEP < 50"

# Question 3
# Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)
# sqldf("select distinct pwgtp1 from acs")
# sqldf("select distinct AGEP from acs")
# sqldf("select unique * from acs")
# sqldf("select unique AGEP from acs")
unique(acs$AGEP)
agep_query <- sqldf("select distinct AGEP from acs")
agep_query

# sqldf("select distinct AGEP from acs")

# Question 4
# How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page: 
        
#        http://biostat.jhsph.edu/~jleek/contact.html 

# (Hint: the nchar() function in R may be helpful)
# 45 31 2 25
# 45 31 7 31
# 45 0 2 2
# 45 92 7 2
# 43 99 7 25
# 45 31 7 25
# 43 99 8 6

con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(con)
close(con)
c(nchar(htmlCode[10]), nchar(htmlCode[20]), nchar(htmlCode[30]), nchar(htmlCode[100]))

# [1] 45 31  7 25


# Question 5
# Read this data set into R and report the sum of the numbers in the fourth of the nine columns. 

# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for 

# Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for 

# (Hint this is a fixed width file format)
# 28893.3
# 36.5
# 101.83

# http://stackoverflow.com/questions/14383710/read-fixed-width-text-file - lol
# This is a fixed width file. Use read.fwf() to read it

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
file2 <- file.path(getwd(), "getdata-wksst8110.for")
download.file(url, file2)
dat <- read.fwf(file2, skip=4, widths=c(-12, -7,-4, 9,-4, -9,-4, -9,4))
head(dat)
colsums(dat)
#  V1         V2 
# 32426.7    36.5 
sum(dat)
# [1] 32463.2


# OR this would have been better and less lines.
# x <- read.fwf(file2, 
#              file=url("http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for"),
#              skip=4,
#              widths=c(12, 7,4, 9,4, 9,4, 9,4))
# head(x)
# determining widths df <- read.fwf(file=url("http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for"), widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4), skip=4)
# ref : https://www.inkling.com/read/r-cookbook-paul-teetor-1st/chapter-4/recipe-4-6
# regex for the widths (not sure how to use this)
# \s[0-9]{2}[A-Z]{3}[0-9]{4}(\s{5}[0-9]+\.[0-9]+[ -][0-9]+\.[0-9]+){4}









