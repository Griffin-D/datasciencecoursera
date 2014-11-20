
# subsetting and sorting
set.seed(13435)
X <- data.frame("var1" = sample(1:5), "var2" = sample(6:10), "var3" = sample(11:15))
X <- X[sample(1:5),]; X$var2[c(1,3)] = NA
X

# subsetting
X[1]
X[,"var1"]
X[1:2, "var2"]

# subsetting with logical ands and ors
X[(X$var1 <= 3 & X$var3 > 11),]
X[(X$var1 <= 3 | X$var3 > 15),]

# missing values
X[which(X$var2 > 8),]

# sorting
sort(X$var1)
sort(X$var1, decreasing = TRUE)
sort(X$var2, na.last = TRUE)

# ordering
X[order(X$var1),]
X[order(X$var1, X$var3),]

# ordering with plyr
library(plyr)
arrange(X, var1)
arrange(X, desc(var1))

# adding rows and columns
X$var4 <- rnorm(5)
X
Y <- cbind(X, rnorm(5))
Y
Y <- cbind(rnorm(5), X)
Y
Y <- rbind(X, rnorm(5))
Y
Y <- rbind(rnorm(5), X)
Y
# more info on subsetting 
# http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%202.pdf

# Summarizing Data
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?acessType=DOWNLOAD"
download.file(fileUrl, destfile = "restaurants.csv", method ="auto")
restData <- read.csv("restaurants.csv")
head(restData, n=3)
tail(restData, n=3)
summary(restData)
str(restData)
quantile(restData$councilDistrict, na.rm = TRUE)
quantile(restData$councilDistrict, probs = c(0.5,0.75,0.9))
table(restData$zipCode, useNA = "ifany")
# important to use useNA = "ifany" because table dows not include them by default

# Create two demensional table 
table(restData$councilDistrict, restData$zipCode)

#check for missing values rturns 1 if missing 0 if not
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode > 0)

# sums across columns and rows
colSums(is.na(restData))
all(colSums(is.na(restData)) == 0)
rowSums(is.na(restData))
all(rowSums(is.na(restData)) == 0)

# values with specific characteristics
table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212", "21213"))
restData[restData$zipCode %in% c("21212", "21213"),]

# Cross tabs
data(UCBAdmissions)
DF = as.data.frame(UCBAdmissions)
summary(DF)
xt <- xtabs(Freq ~ Gender + Admit, data = DF)
xt

# Flat tables with large tables
warpbreaks$replicate <- rep(1:9, len = 54)
xt = xtabs(breaks ~., data = warpbreaks)
xt
ftable(xt)

# size of daa sets
fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData), units = "Mb")

# Creating New variables
# Creating sequences
s1 <- seq(1,10, by = 2); s1
s2 <- seq(1,10, length = 3); s2
x <- c(1,3,8,25,100); seq(along = x)

# subsetting variables
restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)

# creating binary variables
restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode < 0)

# catagorical variables out of quantitative variables
restData$zipGroups = cut(restData$zipCode, breaks = quantile(restData$zipCode))
table(restData$zipGroups)
table(restData$zipGroups, restData$zipCode)

# Easier cutting
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g = 4)
table(restData$zipGroups)

# creating factor variables
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)

# levels of factor variables
yesno <- sample(c("yes", "no"), size = 10, replace = TRUE)
yesnofac = factor(yesno, levels=c("yes", "no"))
relevel(yesnofac, ref = "yes")
as.numeric(yesnofac)

# use mutate to create a new version of a variable and add it to a dataframe
library(Hmisc); library(plyr)
restData2 = mutate(restData, zipGroups = cut2(zipCode, g = 4))
table(restData2$zipGroups)

# common transforms
abs(x) # absolute value
sqrt(x) # square root
ceiling(x) # ceiling(3.475 is 4)
floor(x) # floor(3.475 is 3)
round(x, digits = n)  #roun(3.475, digits = 2) is 3.48
signif(x, digits = n) # signif(3.475, digits = 2) is 3.5
cos(x), sin(x) # etc
log(x) # natural logarithm
log2(x), log10(x) # other common logs
exp(x) # exponentiating x

# more info
# http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%202.pdf
# http://statmethods.net/management/functions.html
# http://plyr.had.co.nz/09-user/


# reshaping data
# http://vita.had.co.nz/papers/tidy-data.pdf
# Leek, Taub and Pineda 2011 PLos One

library(reshape2)
head(mtcars)

# melting data frames
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id = c("carname","gear", "cyl"), measure.vars = c("mpg","hp"))
head(carMelt, n = 3)
tail(carMelt, n = 3)

# casting and reformatting
cylData <- dcast(carMelt, cyl ~ variable)
cylData
cylData <- dcast(carMelt, cyl ~ variable, mean)
cylData

# averaging values
head(InsectSprays)
tapply(InsectSprays$count, InsectSprays$spray, sum)

# or

spIns = split(InsectSprays$count, InsectSprays$spray)
spIns

sprCount <- lapply(spIns, sum)
sprCount

# combining and unlisting
unlist(sprCount)
# apply and combine
sapply(spIns, sum)

# another way with plyr
ddply(InsectSprays,.(spray),summarize, sum=sum(count))
# Error: argument "by" is missing, with no default

# calculating new variable and summarizing
spraySums <- ddply(InsectSprays,.(spray),summarize, sum=ave(count, FUN=sum))
head(spraySums)

# see http://plyr.had.co.nz/09-user/
# http://www.slideshare.net/jeffreybreen/reshaping-data-in-r
# http://www.r-bloggers.com/a-quick-primer-on-split-apply-combine-problems/
# also look up acast, arrange, mutate

# merging data
# peer review link
# http://www.plosone.org/article/info:doi/10.1371/journal.pone,0026895

if(!file.exists("./data")){dir.create("./data")}
fileUrl1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr.csv"
fileUrl2 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr.csv"
download.file(fileUrl1, destfile="./data/reviews.csv")
download.file(fileUrl2, destfile="./data/reviews.csv")
reviews = read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")
head(reviews,2)
head(solutions,2)
#files are no longer on dropbox
# merging
names(reviews)
names(solutions)
mergeData = merge(reviews, solutions, by.x="solution_id", by.y="id", all=TRUE)
head(mergedData)

# default is to merge all column names, which is not good
intersect(names(solutions), names(reviews))
mergedData2 = merg(reviews, solutions, all=TRUE)
head(mergedData2)

# using plyr to merge
df1 = data.frame(id=sample(1:10), x=rnorm(10))
df2 = data.frame(id=sample(1:10), y=rnorm(10))
arrange(join(df1, df2), id)

# plyr is best if you have multiple dataframes with common variable
df1 = data.frame(id=sample(1:10), x=rnorm(10))
df2 = data.frame(id=sample(1:10), x=rnorm(10))
df3 = data.frame(id=sample(1:10), x=rnorm(10))
dflist = list(df1,df2,df3)
join_all(dflist)

# more info
# http://www.statmethods.net/management/merging.html
# http://plyr.had.co.nz/
# http://en.wikipedia.org/wiki/Join_(SQL))















