
###Plyr

d1 <-subset(diamonds, carat >3)
d1 <-arrange(d1,desc(price))
d1 <- mutate(d1,diameter = (x+y)/2)
d1 <- mutate(d1, depth_i = z /diameter * 100)

#Summarise
#Summarise works in an analogous way to mutate, except instead of adding columns to an existing data frame, 
#it creates a new data frame. This is particularly useful in conjunction with ddply as 
#it makes it easy to perform group-wise summaries.

transform(df, var1 = expr1, ...)
summarise(df, var1 = expr1, ...)
Transform modifies an existing data frame. 
Summarise creates a new data frame.


#dlply: takes a data frame, splits up in the
#same way as ddply, applies function to
#each piece and combines the results into a list

#ldply: takes a list, splits up into elements,
#applies function to each piece and then
#combines the results into a data frame

#dlply + ldply = ddply




ddply
Split data frame, apply function, and return results in a data frame.

ddply(diamonds, "cut", summarise, avg_price = mean(price))

bnames <- ddply(bnames, c("sex", "year"), transform,  rank = rank(-percent, ties.method = "first"))
 #transform -> add a column  (mutate could also be used)
  






####################
#Using apply, sapply, lapply in R
http://www.r-bloggers.com/using-apply-sapply-lapply-in-r/
http://nsaunders.wordpress.com/2010/08/20/a-brief-introduction-to-apply-in-r/

  

l <- list(list(a=1:3, b=1:3), list(a=3:1, b=3:1))
lapply(l, function(x) x[["a"]])

[[1]]
[1] 1 2 3

[[2]]
[1] 3 2 1


How to subset from a list in R
mylist <- list(1:5, 6:10, 11:15)
sapply(mylist, "[", c(2,3))



######################
reshape2
http://seananderson.ca/2013/10/19/reshape.html




#######

How to sort list by first element in R
L[order(sapply(L, function(x) x[1], simplify=TRUE), decreasing=TRUE)]


How to access the last value in a vector?
last <- function(x) { tail(x, n = 1) }

