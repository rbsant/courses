
##Week1

#Downloading files
#check if the directory exits
if (!file.exists("data")) {
  dir.create("data")
}

fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.csv", method = "curl")
list.files("./data")

#record downloaded date
dateDownloaded <- date()

/
  Some notes about download.file()
·If the url starts with http you can use download.file()
·If the url starts with https on Windows you may be ok
·If the url starts with https on Mac you may need to set method="curl"
·If the file is big, this might take a while
·Be sure to record when 


·If the url starts with http you can use download.file()
·If the url starts with https on Windows you may be ok
·If the url starts with https on Mac you may need to set method="curl"


#Loading flat files - read.table()
cameraData <- read.table("./data/cameras.csv", sep = ",", header = TRUE)

read.csv sets sep="," and header=TRUE 
cameraData <- read.csv("./data/cameras.csv")

In my experience, the biggest trouble with reading flat files are 
quotation marks ` or " placed in data values, setting quote="" often resolves these
·quote - you can tell R whether there are any quoted values quote="" means no quotes.
·na.strings - set the character that represents a missing value. 



#double load (loading titles)
hpc <- read.table("household_power_consumption.txt",
                  skip = 66637, nrow = 2880, sep = ";", 
                  col.names = colnames(read.table(
                    "household_power_consumption.txt",
                    nrow = 1, header = TRUE, sep=";")))


#Read Excel
library(xlsx)
cameraData <- read.xlsx("./data/cameras.xlsx",sheetIndex=1,header=TRUE)

Reading specific rows and columns
colIndex <- 2:3
rowIndex <- 1:4
cameraDataSubset <- read.xlsx("./data/cameras.xlsx",sheetIndex=1,
                              colIndex=colIndex,rowIndex=rowIndex)


#XML
library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl,useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)

rootNode[[1]]
rootNode[[1]][[1]]


Programatically extract parts of the file
xmlSApply(rootNode,xmlValue)

XPath
·/node Top level node
·//node Node at any level
·node[@attr-name] Node with an attribute name
·node[@attr-name='bob'] Node with attribute name attr-name='bob'


Get the items on the menu and prices
xpathSApply(rootNode,"//name",xmlValue)

xpathSApply(rootNode,"//price",xmlValue)


$JSON
#Reading data from JSON {jsonlite package}
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)

Nested objects in JSON
names(jsonData$owner)
jsonData$owner$login

Writing data frames to JSON
myjson <- toJSON(iris, pretty=TRUE)

Convert back to JSON
iris2 <- fromJSON(myjson)



#Data Table
     
·Inherets from data.frame -All functions that accept data.frame work on data.table
·Written in C so it is much faster
·Much, much faster at subsetting, group, and updating

Create data tables just like data frames
library(data.table)
DF = data.frame(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
head(DF,3)

DT = data.table(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
head(DT,3)

See all the data tables in memory
tables()


Subsetting rows
DT[2,]
DT[DT$y=="a",]
DT[c(2,3)]


Column subsetting in data.table
·The subsetting function is modified for data.table
·The argument you pass after the comma is called an "expression"
·In R an expression is a collection of statements enclosed in curley brackets {

DT[,list(mean(x),sum(z))]
DT[,table(y)]


Adding new columns
DT[,w:=z^2]


Careful
DT2 <- DT
DT[, y:= 2]
head(DT,n=3)
head(DT2,n=3)


Multiple operations
DT[,m:= {tmp <- (x+z); log2(tmp+5)}]

plyr like operations
DT[,a:=x>0]

plyr like operations
DT[,b:= mean(x+w),by=a]


Special variables
.N An integer, length 1, containing the numbe r
set.seed(123);
DT <- data.table(x=sample(letters[1:3], 1E5, TRUE))
DT[, .N, by=x]


Keys
DT <- data.table(x=rep(c("a","b","c"),each=100), y=rnorm(300))
setkey(DT, x)
DT['a']


Joins
DT1 <- data.table(x=c('a', 'a', 'b', 'dt1'), y=1:4)
DT2 <- data.table(x=c('a', 'b', 'dt2'), z=5:7)
setkey(DT1, x); setkey(DT2, x)
merge(DT1, DT2)



Fast reading
system.time(fread(file))






##Week2

#MySQL
Connecting to hg19 and listing tables
hg19 <- dbConnect(MySQL(),user="genome", db="hg19",
                    host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)


Get dimensions of a specific table
dbListFields(hg19,"affyU133Plus2")

Read from the table
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)


Select a specific subset
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query); quantile(affyMis$misMatches)

Close the connection
dbDisconnect(hg19)

#SQL
library(sqldf)
myfile <- "household_power_consumption.txt"
mySql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
myData <- read.csv2.sql(myfile,mySql, sep=";")



#HDF5


#WEB
Getting data off webpages - readLines()
con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)


library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes=T)

xpathSApply(html, "//title", xmlValue)
xpathSApply(html, "//td[@id='col-citedby']", xmlValue)


GET from the httr package
library(httr); html2 = GET(url)
content2 = content(html2,as="text")
parsedHtml = htmlParse(content2,asText=TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)


Accessing websites with passwords
pg2 = GET("http://httpbin.org/basic-auth/user/passwd",
    authenticate("user","passwd"))


Using handles
google = handle("http://google.com")
pg1 = GET(handle=google,path="/")
pg2 = GET(handle=google,path="search")



#API










##Quiz2
#counting numbers
fileUrl <- "http://biostat.jhsph.edu/~jleek/contact.html"
tab <- readLines(fileUrl)
nchar(tab[10]);nchar(tab[20]);nchar(tab[30]);nchar(tab[100])


#fixed width column file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(fileUrl, destfile="wkss.for")
dat <- read.fwf(file="wkss.for", skip=4, widths=c(12, 7,4, 9,4, 9,4, 9,4))



##Week3
##Subsetting and sorting
in 2-R




##Summarizing data
quantile(resData$councilDistrict, na.rm=TRUE)
quantile(resData$councilDistric, probs=c(0.5,0.75,0.9))

#make table
tabZ <- table(rsData$zipCode, useNa="ifany")
tabZ[tabZ==max(tabZ)]

#two dimensional table
table( restData$council, restData$zipcode)

#check for missing alues
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))

#row and columns sums
colSums(is.na(restData))
all(colSums(is.na(restData))==0)

#values with specific characteristics
table(restData$zipCode %in% c("21343","23243"))
restData[restData$zipCode %in% c("21343","23243"), ]


#Crosstabs
data(UCBAdmissions)
DF = as.data.frame(UCBAdmissions)
xtabs(Freq ~ Gender + Admit, data = DF)

#Flat tables
xtabs(breaks ~ . ,data=warpbreaks)
xt <- warpbreaks$replicate <- rep(1:9, len = 54)
ftable(xt)

#Size of a data set
print(object.size(fakeData), units="Mb")



##Creating new variables
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"                        
download.file(fileUrl, destfile="./data/restaurants.csv")
restData <- read.csv("./data/restaurants.csv")

#Sequences

Sometimes you need an index for your data set
s1 <- seq(1,10,by=2) ; s1
[1] 1 3 5 7 9

s2 <- seq(1,10,length=3); s2
[1]  1.0  5.5 10.0

x <- c(1,3,8,25,100); seq(along = x)
[1] 1 2 3 4 5




#Subsetting
restData$nearme = restData$neighborhood %in% c("Rolland Park", "Homeland")
table(restData$nearme)


#Creating bin variables
restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong,restData$zipCode < 0)


#Creating categorical varibles (cutting) (produces factors)
restData$zipGroups = cut(restData$zipCode, breaks = quantile(restData$zipCode))
table(restData$zipGroups)

hi_rider = ifelse(dat$daily > 10000, 1, 0)

#easier cutting (produces factors)
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g=4)

#creating factor variables
restData$zcf <- factor(restData$zipCode)

#add a new variable with mutate
library(Hmisc); library(plyr)
restData2 = mutate(restData, zipGroups=cut2(zipCode, g=4))



##Reshaping data
#Melting data frames (each row represents one value)
library(reshape2)
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id=c("carname","gear","cyl"), measure.vars=c("mpg","hp"))

#Casting data frames (aggregate)
dcast(carMelt, cyl ~ variable)
dcast(carMelt, cyl ~ variable, mean)

aggregate(. ~ cyl , data = mtcars, FUN=mean)


#Averaging values
tapply(InsectSprays$count,InsectSprays$spray,sum)

spIns = split(InsectSprays$count, InsectSprays$spray)
sprCount = lapply(spIns,sum)
unlist(sprCount)  # conver to a vector
#equivalent to
sapply(spIns, sum)

ddply(InsectSprays, .(spray), summarize, sum(count))



#Creating a new variable
spraySums <- ddply(InsectSprays,.(spray),summarize,sum=ave(count,FUN=sum))


##Merging data

If we want all the entries in cleanao3 (the first part of the merge, the x value) with the information from the other combined if avaliable, we want
mergeddata <- merge(cleanao3, cleanst3, by="country", all.x = all)

If we want all of the information from cleanst3 plus the information 
mergeddata <- merge(cleanao3, cleanst3, by="country", all.y = all)

If we want all of the information for both, with blank entries on either side where it cannot find a match, then the appropriate version is 
mergeddata <- merge(cleanao3, cleanst3, by="country", all = TRUE)


base <- data.frame(id = 1:10, Age = rnorm(10, mean = 65, sd = 5))
visits <- data.frame(id = rep(1:8, 3), visit = rep(1:3, 8), Outcome = rnorm(2 * 3, mean = 4, sd = 2))
merged.data <- merge(base, visits, by = "id")
table(merged.data$id)

all.data <- merge(base, visits, by = "id", all = TRUE)
table(all.data$id)



#Quizz3
#https://class.coursera.org/getdata-003/forum/thread?thread_id=95

#q1
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"                        
download.file(fileUrl, destfile="./data/UScommunities.csv")
commData <- read.csv("./data/UScommunities.csv")
agricultureLogical <- commData$ACR == 3 & commData$AGS == 6
which(agricultureLogical == TRUE)


#q2
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"                        
#download in binary mode
download.file(fileUrl, destfile="./data/jeff.jpg", mode='wb')
quantile(sort(jeffImage), probs=c(0.3,0.8))


#q3 Match the data based on the country shortcode. How many of the IDs match? 
#Sort the data frame in descending order by GDP rank. What is the 13th country in the resulting data frame? 

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"                        
download.file(fileUrl, destfile="./data/dataGDP.csv")
dataGDP <- read.csv("./data/dataGDP.csv", na.strings="..",  header=FALSE, stringsAsFactors=FALSE, blank.lines.skip=FALSE)
dataGDP <- dataGDP[,c(1,2,4,5)]
names(dataGDP)=c("CountryCode","Ranking","CountryName", "GDP2012")

#delete empty rows
dataGDP <- dataGDP[-which(dataGDP$CountryCode==""),]

dataGDP$Ranking <- as.integer(dataGDP$Ranking)
dataGDP$GDP2012 <- as.numeric(gsub(",","", dataGDP$GDP2012))
#delete empty rankings
dataGDP <- dataGDP[!is.na(dataGDP$Ranking),]


fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"                        
download.file(fileUrl, destfile="./data/dataEdu.csv")
dataEdu <- read.csv("./data/dataEdu.csv", stringsAsFactors=FALSE, blank.lines.skip=TRUE)

#Discover countries not matchhing
dataGDP$CountryCode[!(dataGDP$CountryCode %in% dataEdu$CountryCode)]
dataEdu$CountryCode[!(dataEdu$CountryCode %in% dataGDP$CountryCode)]

#left merge (by countries with Raking number)
mergeDat = merge(dataGDP, dataEdu, by="CountryCode", all.x=TRUE)

mergeDat[order(mergeDat$Ranking),c("Ranking","CountryCode","CountryName","GDP2012")]


#q4 What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group? 
mergeDat$Income.Group <- as.factor(mergeDat$Income.Group)
tapply(mergeDat$Ranking,mergeDat$Income.Group, mean, na.rm=TRUE)


#q5 Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. 
#How many countries are Lower middle income but among the 38 nations with highest GDP?
mergeDat$rankgroup <- cut2(mergeDat$Ranking, g=5)
table(mergeDat$rankgroup)
#mergeDat$rankgroup <- cut(mergeDat$Ranking, breaks = quantile(mergeDat$Ranking, na.rm=TRUE))







##Week4
#Fixing character vectors - tolower(), toupper()
tolower(names(cameraData))

Fixing character vectors - strsplit()
·Good for automatically splitting variable names
·Important parameters: x, split
splitNames = strsplit(names(cameraData),"\\.")

firstElement <- function(x){x[1]}   #takes the first element
sapply(splitNames,firstElement)

  
Fixing character vectors - gsub()
testName <- "this_is_a_test"
sub("_","",testName)
gsub("_","",testName)


#Finding values - grep(),grepl()
grep("Alameda",cameraData$intersection)
[1]  4  5 36
grep("Alameda",cameraData$intersection,value=TRUE)
[1] "The Alameda  & 33rd St"   "E 33rd  & The Alameda"    "Harford \n & The Alameda"

table(grepl("Alameda",cameraData$intersection))

cameraData2 <- cameraData[!grepl("Alameda",cameraData$intersection),]


#text functions
Extract
substr("Jeffrey Leek",1,7)
[1] "Jeffrey"

Paste
paste("Jeffrey","Leek")
[1] "Jeffrey Leek"

paste0("Jeffrey","Leek")
[1] "JeffreyLeek"

str_trim("Jeff      ")
[1] "Jeff"


times <- c("purple", "green", "orange", "banner")
v.names <- c("Boardings", "Alightings", "Average")
print(varying <- c(sapply(times, paste, sep = "", v.names)))


#Regular expressions
Used with the functions grep,grepl,sub,gsub and others that involve searching for text strings 
Some metacharacters represent the start of a line
^i think

$ represents the end of a line
morning$


We can list a set of characters we will accept at a given point in the match
[Bb][Uu][Ss][Hh]
^[0-9][a-zA-Z]


When used at the beginning of a character class, the “” is also a metacharacter and indicates matching characters NOT in the indicated class
[^?.]$


“.” is used to refer to any character. So
9.11

This does not mean “pipe” in the context of regular expressions; instead it translates to “or”; we can use it to combine two expressions, the subexpressions being called alternatives
flood|fire

The alternatives can be real expressions and not just literals (could be both)
^[Gg]ood|[Bb]ad

Subexpressions are often contained in parentheses to constrain the alternatives (only one)
^([Gg]ood|[Bb]ad)


More Metacharacters: ?
The question mark indicates that the indicated expression is optional
[Gg]eorge( [Ww]\.)? [Bb]ush


The * and + signs are metacharacters used to indicate repetition; 
  * means “any number, including none, of the item” and 
  + means “at least one of the item”
(.*) 
[0-9]+ (.*)[0-9]+


{ and } are referred to as interval quantifiers; the let us specify the minimum and maximum number of matches of an expression
[Bb]ush( +[^ ]+ +){1,5} debate


More metacharacters: and
·m,n means at least m but not more than n matches 
·m means exactly m matches
·m, means at least m matches


More metacharacters: ( and ) revisited
·In most implementations of regular expressions, the parentheses not only limit the scope of alternatives divided by a “|”, but also can be used to “remember” text matched by the subexpression enclosed
·We refer to the matched text with \1, \2, etc.
+([a-zA-Z]+) +\1 

The * is “greedy” so it always matches the longest possible string that satisfies the regular expression. So
^s(.*)s

The greediness of * can be turned off with the ?, as in
^s(.*?)s$







##Quiz4
q1
if (!file.exists("data")) {
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/ss06hid.csv")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
download.file(fileUrl, destfile = "./data/DataDict06.pdf",mode="wb")
list.files("./data")

df <- read.csv(file="./data/ss06hid.csv")
splitNames = strsplit(names(df),"wgtp")


q2
if (!file.exists("data")) {
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile = "./data/FGDP.csv")

dfgdp <- read.csv(file="./data/FGDP.csv")
dfgdp <- dfgdp[5:194,c(1,2,4,5)]
names(dfgdp) <- c("countrycode","ranking", "country", "gdp2012" )
dfgdp$gdp2012 = as.numeric(gsub(",","", dfgdp$gdp2012))

q3
mean(dfgdp$gdp2012)


q4
if (!file.exists("data")) {
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile = "./data/FGDP.csv")

dfgdp <- read.csv(file="./data/FGDP.csv")
dfgdp <- dfgdp[5:194,c(1,2,4,5)]
names(dfgdp) <- c("CountryCode","ranking", "country", "gdp2012" )
dfgdp$gdp2012 = as.numeric(gsub(",","", dfgdp$gdp2012))

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl, destfile = "./data/FEDSTATS_Country.csv")
dfedu <- read.csv("./data/FEDSTATS_Country.csv")

 
dfmerge <- merge(dfgdp, dfedu, by="CountryCode")  # no with all!!
grep("Fiscal .* June",dfmerge$Special.Notes, value=TRUE)


q5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 

sampleTimes[grep("2012",sampleTimes)]
sum(as.logical(sample2012))
sum(as.logical(grep("Monday",weekdays(sample2012))))






#calculate fastest method
options(digits=10)
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time({mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)})
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time({rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]})
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(DT[,mean(pwgtp15),by=SEX])

