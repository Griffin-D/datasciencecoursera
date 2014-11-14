## Set the working directory to the folder for the class
setwd("C:\\Users\\debgriff\\Documents\\Getting and Cleaning Data")

## Get the files
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

## Check for the directory, create it if it does not exist
    if (!file.exists("data")) {
        dir.create("data")
    }
download.file(fileUrl, destfile = ".\\data\\housing.csv")
list.files(".\\data")
dateDownloaded <- date()
dateDownloaded

## Read the data
housingData <- read.table("./data/housing.csv", sep = ",", header = TRUE)

## Get rid of the NA's (make tidy)
Expensive <- na.omit(housingData["VAL"])

## Get the number of properties greater than, or equal to 1,000.000
expensiveCount <- Expensive$VAL >= 24

## Count the properties that are worth 1,000.000, or more 
sum(expensiveCount[TRUE])

## Count is 53

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
f <- file.path(getwd(), "PUMSDataDict06.pdf")
download.file(url, f)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
f <- file.path(getwd(), "ss06pid.csv")
download.file(url, f)
##
## How many housing units in this survey were worth more than $1,000,000?
##
require(data.table)
dt <- data.table(read.csv(f))
setkey(dt, VAL)
dt[, .N, key(dt)]

## Question 2
##
## Use the data you loaded from Question 1. Consider the variable FES in the code book. Which of the "tidy data" principles does this variable violate?
setkey(dt, FES)
dt[, .N, key(dt)]

Question 3
## 
## Download the Excel spreadsheet on Natural Gas Aquisition Program here: 
## 
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx 
## 
## Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:
## 
## dat
## 
## What is the value of:
## 
## sum(dat$Zip*dat$Ext,na.rm=T) 
## 
## (original data source: http://catalog.data.gov/dataset/natural-gas-acquisition-program)

sum(dat$Zip*dat$Ext,na.rm=T) 

if(!file.exists("data")){dir.create("data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl,destfile=".\\data\\DATA.gov_NGAP.xlsx")
dateDownloaded <- date()
dateDownloaded
f <- ".\\data\\DATA.gov_NGAP.xlsx" 
library(xlsx)
cols <- 18:23
rows <- 7:15
dat <- read.xlsx(f, 1, colIndex=cols, rowIndex=rows)
sum(dat$Zip*dat$Ext,na.rm=T)

readWorksheet ( object , sheet , startRow , startCol , endRow , endCol ,
                header = TRUE )


