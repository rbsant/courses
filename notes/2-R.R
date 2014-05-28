
Decimals values like 4.5 are called numerics.
Natural numbers like 4 are called integers.
Boolean values (TRUE or FALSE) are called logical (TRUE can be abbreviated to T and FALSE to F).
Text (or string) values are called character.


#vectors
x <- 1:3
names(x) <- c("uno", "dos", "tres")

#Matrices: cbind rbind
x <- 1:3
y <- 10:12
cbind(x, y)
rbind(x, y) 

m <- matrix(1:4, nrow = 2, ncol = 2)
dimnames(m) <- list(c("a", "b"), c("c", "d")) 



#lists
x <- list(1, "a", TRUE, 1 + 4i) 
names(x) <- c("uno", "dos", "tres", "cuatro")

#factors
gl() 

x <- factor(c("yes", "yes", "no", "yes", "no")) 
table(x) 

unclass(x)

factor(c("case", "case", "case", "control", "control", "control"), labels = c("control", "case")

ordered factor
factor(c("case", "case", "case", "control", "control", "control"), labels = c("control","case"), ordered = TRUE)
     


#The order of the levels can be set using the levels argument to factor(). This can be important in linear modelling because the first level is used as the baseline level.
x <- factor(c("yes", "yes", "no", "yes", "no"),
              levels = c("yes", "no"))



#data frames
#Data frames has a special attribute called row.names
#Data frames are usually created by calling read.table() or read.csv()
#Can be converted to a matrix by calling data.matrix()

x <- data.frame(foo = 1:4, bar = c(T, T, F, F)) 
names(x)





##subsetting
There are a number of operators that can be used to extract subsets of R objects.
·[ always returns an object of the same class as the original; can be used to select more than one element (there is one exception)
·[[ is used to extract elements of a list or a data frame; it can only be used to extract a single element and the class of the returned object will not necessarily be a list or data frame    
·$ is used to extract elements of a list or data frame by name; semantics are similar to hat of [[.
                                                                                                  
x <- c("a", "b", "c", "c", "d", "a")                                                                                                 
x[x > "a"]
      

#Subsetting a Matrix                                                                                                 
drop = FALSE : Retrieve a Matrix
x <- matrix(1:6, 2, 3)
x[1, 2]
[1] 3
x[1, 2, drop = FALSE]
[,1]
[1,] 3


#Subsetting Lists
x <- list(foo = 1:4, bar = 0.6)
x[1]
$foo
[1] 1 2 3 4

x[[1]]
[1] 1 2 3 4

x$bar
[1] 0.6
x[["bar"]]
[1] 0.6
x["bar"]
$bar
[1] 0.6

x <- list(foo = 1:4, bar = 0.6, baz = "hello")
x[c(1, 3)]
$foo
[1] 1 2 3 4

$baz
[1] "hello"

#Subsetting Nested Elements of a List 
The [[ can take an integer sequence.
x <- list(a = list(10, 12, 14), b = c(3.14, 2.81))
x[[c(1, 3)]]
[1] 14

x[[1]][[3]]
[1] 14

x[[c(2, 1)]]
[1] 3.14


#removing NA values
A common task is to remove missing values (NAs).
x <- c(1, 2, NA, 4, NA, 5) 
bad <- is.na(x)
x[!bad]
[1] 1 2 4 5

What if there are multiple things and you want to take the subset with no missing values?
x <- c(1, 2, NA, 4, NA, 5)
y <- c("a", "b", NA, "d", NA, "f")
good <- complete.cases(x, y)
good
[1]  TRUE  TRUE FALSE  TRUE FALSE  TRUE
x[good]
[1] 1 2 4 5
y[good]
[1] "a" "b" "d" "f"


#Dealing with missing values
x[which(x > 0 )]   #retunrs the INDEXES
which.min
which.max


#number of distinct elements
df <- mon[mon$neighborhood=="Downtown",]
unique(df$zipCode)

tab <- table(mon$zipCode, mon$neighborhood)
unique(tab[,"Downtown"])


#sorting (for a vector)
set.seed(13435)
X <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
X <- X[sample(1:5),]; X$var2[c(1,3)] = NA

#Note that this returns an object that has been sorted/ordered
sort(X$var1)
[1] 1 2 3 4 5

sort(X$var1,decreasing=TRUE)
[1] 5 4 3 2 1

sort(X$var2,na.last=TRUE)
[1]  6  9 10 NA NA


#Ordering (for a matrix, factor)
#Note that this returns the indices corresponding to the sorted data.
> order(X$var1)
[1] 2 1 3 5 4

X[order(X$var1),]


#Ordering with plyr
library(plyr)
arrange(X,var1)

Adding rows and columns
X$var4 <- rnorm(5)
Y <- cbind(X,rnorm(5))




#Reading Data

There are a few principal functions reading data into R. 
·read.table, read.csv, for reading tabular data 
·readLines, for reading lines of a text file
·source, for reading in R code files (inverse of dump) 
·dget, for reading in R code files (inverse of dput)
·load, for reading in saved workspaces
·unserialize, for reading single R objects in binary form

Writing Data

There are analogous functions for writing data to files
·write.table
·writeLines
·dump
·dput
·save
·serialize


#Reading in Larger Datasets with read.table
Use the colClasses argument. 
Specifying this option instead of using the default can make ’read.table’ run MUCH faster, often twice as fast. In order to use this option, you have to know the class of each column in your data frame.
A quick an dirty way to figure out the classes of each column is the following:

initial <- read.table("datatable.txt", nrows = 100)
classes <- sapply(initial, class)
tabAll <- read.table("datatable.txt", colClasses = classes)




##COntrol Structures

##Functions

Functions in R are “first class objects”, which means that they can be treated much like any other R object. Importantly,
·Functions can be passed as arguments to other functions
·Functions can be nested, so that you can define a function inside of another function
·The return value of a function is the last expression in the function body to be evaluated.

# your values
list1<-1:10
list2<-letters[1:26]
list3<-25:32

# put 'em together in a list
mylist<-list(list1,list2,list3)

# function
foo<-function(x){x[c(3,5,9)]}

# apply function to each of the element in the list
foo(mylist[[1]])
foo(mylist[[2]])
foo(mylist[[3]])

# check the output

> foo(mylist[[1]])
[1] 3 5 9
> foo(mylist[[2]])
[1] "c" "e" "i"
> foo(mylist[[3]])
[1] 27 29 NA


Run function in data frames within list
lapply(temp, function(x) { names(x) = tolower(names(x)); x })



#scoping rules
When R tries to bind a value to a symbol, it searches through a series of environments to find the appropriate value. When you are working on the command line and need to retrieve the value of an R object, the order is roughly
1.Search the global environment for a symbol name matching the one requested.
2.Search the namespaces of each of the packages on the search list
The search list can be found by using the search function.
> search()



Lexical Scoping
Searching for the value for a free variable:
-Up to parent enviromen  ->  top-level enviroment
-Down the search list  -> empy enviroment
  ·If the value of a symbol is not found in the environment in which a function was defined, then the search is continued in the parent environment.
·The search continues down the sequence of parent environments until we hit the top-level environment; this usually the global environment (workspace) or the namespace of a package.
·After the top-level environment, the search continues down the search list until we hit the empty environment. If a value for a given symbol cannot be found once the empty environment is arrived at, then an error is thrown.


Lexical vs. Dynamic Scoping
·With lexical scoping the value of a free variable is looked up in the environment in which the function was defined.
·With dynamic scoping, the value of y is looked up in the environment from which the function was called (sometimes referred to as the calling environment). -In R the calling environment is known as the parent frame 



#vectorized operation
x * y       ## element-wise multiplication
x %*% y     ## true matrix multiplication




#dates
·Dates use the Date class

Starting simple
d1 = date()
[1] "Sun Jan 12 17:48:33 2014"
class(d1)
[1] "character"

d2 = Sys.Date()
[1] "2014-01-12"
class(d2)
[1] "Date"


Formatting dates
%d = day as number (0-31), %a = abbreviated weekday,%A = unabbreviated weekday, %m = month (00-12), %b = abbreviated month, %B = unabbrevidated month, %y = 2 digit year, %Y = four digit year
format(d2,"%a %b %d")
[1] "Sun Jan 12"


Converting to Julian
weekdays(d2)
[1] "Sunday"

months(d2)
[1] "January"

julian(d2)
[1] 16082
attr(,"origin")
[1] "1970-01-01"

Lubridate
library(lubridate); ymd("20140108")
[1] "2014-01-08 UTC"

mdy("08/04/2013")
[1] "2013-08-04 UTC"

dmy("03-04-2013")
[1] "2013-04-03 UTC"


·Character strings can be coerced to Date/Time classes using the 
strptime function or the as.Date, as.POSIXlt, or as.POSIXct
x <- as.Date("2012-01-01")
y <- strptime("9 Jan 2011 11:34:21", "%d %b %Y %H:%M:%S") 
x-y
## Warning: Incompatible methods ("-.Date",
## "-.POSIXt") for "-"
## Error: non-numeric argument to binary operator
x <- as.POSIXlt(x) 
x-y
## Time difference of 356.3 days



Creating dates
x = c("1jan1960", "2jan1960", "31mar1960", "30jul1960"); z = as.Date(x, "%d%b%Y")

[1] "1960-01-01" "1960-01-02" "1960-03-31" "1960-07-30"

z[1] - z[2]
Time difference of -1 days

as.numeric(z[1]-z[2])
[1] -1





x <- as.Date("1970-01-01")
x
[1] "1970-01-01"
unclass(x)
[1] 0
unclass(as.Date("1970-01-02"))
[1] 1



Dealing with times
ymd_hms("2011-08-03 10:15:03")
[1] "2011-08-03 10:15:03 UTC"

ymd_hms("2011-08-03 10:15:03",tz="Pacific/Auckland")
[1] "2011-08-03 10:15:03 NZST"

?Sys.timezone

Some functions have slightly different syntax
x = dmy(c("1jan2013", "2jan2013", "31mar2013", "30jul2013"))
wday(x[1])
[1] 3

wday(x[1],label=TRUE)
[1] Tues
Levels: Sun < Mon < Tues < Wed < Thurs < Fri < Sat






Times use the POSIXct and POSIXlt class
·POSIXct is just a very large integer under the hood; it use a useful class when you want to store times in something like a data frame
·POSIXlt is a list underneath and it stores a bunch of other useful information like the day of the week, day of the year, month, day of the month


There are a number of generic functions that work on dates and times
·weekdays: give the day of the week
·months: give the month name
·quarters: give the quarter number (“Q1”, “Q2”, “Q3”, or “Q4”)




POSIXlt format
x <- Sys.time()
x  ## Already in ‘POSIXct’ format
 [1] "2013-01-24 22:04:14 EST"
unclass(x)
 [1] 1359083054
x$sec
 Error: $ operator is invalid for atomic vectors
p <- as.POSIXlt(x)
p$sec
 [1] 14.37



You can also use the POSIXct format.
x <- Sys.time()
x  ## Already in ‘POSIXct’ format
 [1] "2013-01-24 22:04:14 EST"
unclass(x)
 [1] 1359083054
x$sec
 Error: $ operator is invalid for atomic vectors
p <- as.POSIXlt(x)
p$sec
 [1] 14.37


Finally, there is the strptime function in case your dates are written in a different format
datestring <- c("January 10, 2012 10:40", "December 9, 2011 09:10")
x <- strptime(datestring, "%B %d, %Y %H:%M")
x
 [1] "2012-01-10 10:40:00" "2011-12-09 09:10:00"
class(x)
 [1] "POSIXlt" "POSIXt"


You can use mathematical operations on dates and times. Well, really just + and -. You can do comparisons too (i.e. ==, <=)
x <- as.Date("2012-01-01")
y <- strptime("9 Jan 2011 11:34:21", "%d %b %Y %H:%M:%S") 
x-y
## Warning: Incompatible methods ("-.Date",
## "-.POSIXt") for "-"
## Error: non-numeric argument to binary operator
x <- as.POSIXlt(x) 
x-y
## Time difference of 356.3 days






#Looping on the command line
lapply: Loop over a list and evaluate a function on each element 
sapply: Same as lapply but try to simplify the result
apply: Apply a function over the margins of an array
tapply: Apply a function over subsets of a vector
mapply: Multivariate version of lapply


#lapply
lapply always returns a list, regardless of the class of the input.
x <- list(a = 1:5, b = rnorm(10))
lapply(x, mean)

x <- 1:4
lapply(x, runif, min = 0, max = 10)


x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2)) 
An anonymous function for extracting the first column of each matrix.
lapply(x, function(elt) elt[,1])


#apply
x <- matrix(rnorm(200), 20, 10)
apply(x, 2, mean)
apply(x, 1, sum)

For sums and means of matrix dimensions, we have some shortcuts.
·rowSums = apply(x, 1, sum)
·rowMeans = apply(x, 1, mean)
·colSums = apply(x, 2, sum)
·colMeans = apply(x, 2, mean)

The shortcut functions are much faster, but you won’t notice unless you’re using a large matrix.


Quantiles of the rows of a matrix.
x <- matrix(rnorm(200), 20, 10)
apply(x, 1, quantile, probs = c(0.25, 0.75))


#tapply
> x <- c(rnorm(10), runif(10), rnorm(10, 1))
> f <- gl(3, 10)
> f
[1] 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3 3
[24] 3 3 3 3 3 3 3
Levels: 1 2 3
> tapply(x, f, mean)
1         2         3 
0.1144464 0.5163468 1.2463678

tapply(x, f, range)


#split
> x <- c(rnorm(10), runif(10), rnorm(10, 1))
> f <- gl(3, 10)
> split(x, f)

    
A common idiom is split followed by an lapply.
> lapply(split(x, f), mean)


Splitting a Data Frame
> s <- split(airquality, airquality$Month)
> lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))
> sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")])) 
> sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")],na.rm = TRUE))
                                 

Splitting on More than One Level
> x <- rnorm(10)
> f1 <- gl(2, 5)
> f2 <- gl(5, 2)
> interaction(f1, f2)
str(split(x, list(f1, f2), drop = TRUE))  #drop empty levels


#mapply
The following is tedious to type

list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1))
Instead we can do
> mapply(rep, 1:4, 4:1)
[[1]]
[1] 1 1 1 1

[[2]]
[1] 2 2 2

[[3]] 
[1] 3 3

[[4]] 
[1] 4

Vectorizing a Function
> noise <- function(n, mean, sd) {
  + rnorm(n, mean, sd)
  + }
> noise(5, 1, 2)
[1]  2.4831198  2.4790100  0.4855190 -1.2117759
[5] -0.2743532

> noise(1:5, 1:5, 2)
[1] -4.2128648 -0.3989266  4.2507057  1.1572738
[5]  3.7413584


  
  
#Debugging Tools in R

The primary tools for debugging functions in R are
·traceback: prints out the function call stack after an error occurs; does nothing if there’s no error
·debug: flags a function for “debug” mode which allows you to step through execution of a function one line at a time
·browser: suspends the execution of a function wherever it is called and puts the function in debug mode
·trace: allows you to insert debugging code into a function a specific places 
·recover: allows you to modify the error behavior so that you can browse the function call stack




#Generating Random Numbers

Functions for probability distributions in R
·rnorm: generate random Normal variates with a given mean and standard deviation
·dnorm: evaluate the Normal probability density (with a given mean/SD) at a point (or vector of points)
·pnorm: evaluate the cumulative distribution function for a Normal distribution 
·rpois: generate random Poisson variates with a given rate


Probability distribution functions usually have four functions associated with them. The functions are prefixed with a
·d for density
·r for random number generation 
·p for cumulative distribution
·q for quantile function

  
Working with the Normal distributions requires using these four functions
dnorm(x, mean = 0, sd = 1, log = FALSE)
pnorm(q, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
qnorm(p, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
rnorm(n, mean = 0, sd = 1)




#Random Sampling

The sample function draws randomly from a specified set of (scalar) objects allowing you to sample from arbitrary distributions.
> set.seed(1)
> sample(1:10, 4)
[1] 3 4 5 7
> sample(1:10, 4)
[1] 3 9 8 5
> sample(letters, 5)
[1] "q" "b" "e" "x" "p"
> sample(1:10)  ## permutation
[1] 4 710 6 9 2 8 3 1 5 
> sample(1:10)
[1]  2  3  4  1  9  5 10  8  6  7
> sample(1:10, replace = TRUE)  ## Sample w/replacement
[1] 2 9 7 8 2 8 5 9 7 8




#Using system.time()

Computes the time (in seconds) needed to execute an expression
-If there’s an error, gives time until the error occurred

Returns an object of class proc_time
-user time: time charged to the CPU(s) for this expression
-elapsed time: "wall clock" time



#The R Profiler

The Rprof() function starts the profiler in R
-R must be compiled with profiler support (but this is usually the case)
The summaryRprof() function summarizes the output from Rprof() (otherwise it’s not readable)
DO NOT use system.time() and Rprof() together or you will be sad

Rprof() keeps track of the function call stack at regularly sampled intervals and tabulates how much time is spend in each function
Default sampling interval is 0.02 seconds

NOTE: If your code runs very quickly, the profiler is not useful, but then you probably don't need it in that case

Good to break your code into functions so that the profiler can give useful information about where time is being spent

"by.total" divides the time spend in each function by the total run time
"by.self" does the same but first subtracts out time spent in functions above in the call stack




