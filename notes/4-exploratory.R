


##Week1
##Exploratory Grpahs
#Five number summary
summary(pollution$pm25)

#boxplot
boxplot(pollution$pm25, col = "blue")

#histogram
hist(pollution$pm25, col = "green")
rug(pollution$pm25)

hist(pollution$pm25, col = "green", breaks = 100)
rug(pollution$pm25)

#overlaying features
boxplot(pollution$pm25, col = "blue")
abline(h = 12)

hist(pollution$pm25, col = "green")
abline(v = 12, lwd = 2)
abline(v = median(pollution$pm25), col = "magenta", lwd = 4)


#barplot
barplot(table(pollution$region), col = "wheat", main = "Number of Counties in Each Region")


#multiple boxplots
boxplot(pm25 ~ region, data = pollution, col = "red")

#multiple histograms
par(mfrow = c(2, 1), mar = c(4, 4, 2, 1))
hist(subset(pollution, region == "east")$pm25, col = "green")
hist(subset(pollution, region == "west")$pm25, col = "green")


#scatterplot
with(pollution, plot(latitude, pm25, col = region))
abline(h = 12, lwd = 2, lty = 2)

#multiple scatterplots
par(mfrow = c(1, 2), mar = c(5, 4, 2, 1))
with(subset(pollution, region == "west"), plot(latitude, pm25, main = "West"))
with(subset(pollution, region == "east"), plot(latitude, pm25, main = "East"))



##Plottign systems

#Base: "artist's palette" model
#Lattice: Entire plot specified by one function; conditioning
#ggplot2: Mixes elements of Base and Lattice



##base plot
#There are two phases to creating a base plot
  #Initializing a new plot
  #Annotating (adding to) an existing plot


#Many base plotting functions share a set of parameters. Here are a few key ones:
# pch: the plotting symbol (default is open circle)
# lty: the line type (default is solid line), can be dashed, dotted, etc.
# lwd: the line width, specified as an integer multiple
# col: the plotting color, specified as a number, string, or hex code; the colors() function gives
#  you a vector of colors by name
# xlab: character string for the x-axis label
# ylab: character string for the y-axis label

#The par() function is used to specify global graphics parameters that affect all plots in an R
#session. These parameters can be overridden when specified as arguments to specific plotting
#functions.
# las: the orientation of the axis labels on the plot
# bg: the background color
# mar: the margin size
# oma: the outer margin size (default is 0 for all sides)
# mfrow: number of plots per row, column (plots are filled row-wise)
# mfcol: number of plots per row, column (plots are filled column-wise)

#Base Plotting Functions
#plot: make a scatterplot, or other type of plot depending on the class of the object being plotted
#lines: add lines to a plot, given a vector x values and a corresponding vector of y values (or a 2-column matrix); this function just connects the dots
#points: add points to a plot
#text: add text labels to a plot using specified x, y coordinates
#title: add annotations to x, y axis labels, title, subtitle, outer margin
#mtext: add arbitrary text to the margins (inner or outer) of the plot
#axis: adding axis ticks/labels

# example(points)



library(datasets)
par(mfrow =c(1,1))

#Histogram
hist(airquality$Ozone) ## Draw a new plot

#scatterplot
with(airquality, plot(Wind, Ozone))

#boxplot
airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)")

#title
with(airquality, plot(Wind, Ozone))
title(main = "Ozone and Wind in New York City") 

#text
with(airquality, plot(Wind, Ozone))
text( 15,160,"New York City") 

#points
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))


#Plotting different groups in same plot 
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City",
                      type = "n"))   ## Createss empty plot
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col = "red"))
legend("topright", pch = 1, col = c("blue", "red"), legend = c("May", "Other Months"))


#regression line
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City",
                      pch = 20))
model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd = 2)


#multiple base plots
par(mfrow = c(1, 2))
with(airquality, {
  plot(Wind, Ozone, main = "Ozone and Wind")
  plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
})


#multiple base plots
par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0)) 
                      ## bigger margins on the bottom and on the left to accomodate labels
with(airquality, {
  plot(Wind, Ozone, main = "Ozone and Wind")
  plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
  plot(Temp, Ozone, main = "Ozone and Temperature")
  mtext("Ozone and Weather in New York City", outer = TRUE)
})


par(mfrow =c(1,1))


##Graphics devices
#The most common place for a plot to be "sent" is the screen device
#On a Mac the screen device is launched with the quartz()
#On Windows the screen device is launched with windows()
#On Unix/Linux the screen device is launched with x11()

#The currently active graphics device can be found by calling dev.cur()
#Every open graphics device is assigned an integer ≥2.
#You can change the active graphics device with dev.set(<integer>) where <integer> is the number associated with the graphics device you want to switch to

pdf(file = "myplot.pdf")  ## Open PDF device; create 'myplot.pdf' in my working directory
## Create plot and send to a file (no plot appears on screen)
with(faithful, plot(eruptions, waiting))
title(main = "Old Faithful Geyser data")  ## Annotate plot; still nothing on screen
dev.off()  ## Close the PDF file device
## Now you can view the file 'myplot.pdf' on your computer


#Copying plots

dev.copy: copy a plot from one device to another

dev.copy2pdf: specifically copy a plot to a PDF file

#NOTE: Copying a plot is not an exact operation, so the result may not be identical to the original.
library(datasets)
with(faithful, plot(eruptions, waiting))  ## Create plot on screen device
title(main = "Old Faithful Geyser data")  ## Add a main title
dev.copy(png, file = "geyserplot.png")  ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device!



##Week3

##Lattice plottig system

#Lattice Functions

#xyplot: this is the main function for creating scatterplots
#bwplot: box-and-whiskers plots (“boxplots”)
#histogram: histograms
#stripplot: like a boxplot but with actual points
#dotplot: plot dots on "violin strings"
#splom: scatterplot matrix; like pairs in base plotting system
#levelplot, contourplot: for plotting "image" data

#xyplot(y ~ x | f * g, data)

#We use the formula notation here, hence the ~.

#On the left of the ~ is the y-axis variable, on the right is the x-axis variable

#f and g are conditioning variables — they are optional
#the * indicates an interaction between two variables

#The second argument is the data frame or list from which the variables in the formula should be looked up
#If no data frame or list is passed, then the parent frame is used.

#If no other arguments are passed, there are defaults that can be used.


#scatterplot
library(lattice)
library(datasets)
# Simple scatterplot
xyplot(Ozone ~ Wind, data = airquality)


#Multiple scatterplot
# Convert 'Month' to a factor variable
airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5, 1))


#Lattice behaviour
p <- xyplot(Ozone ~ Wind, data = airquality)  ## Nothing happens!
print(p)  ## Plot appears



#Lattice Panel Functions
#Lattice functions have a panel function which controls what happens inside each panel of the plot.

#2 pannels
set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x + f - f * x + rnorm(100, sd = 0.5)
f <- factor(f, labels = c("Group 1", "Group 2"))
xyplot(y ~ x | f, layout = c(2, 1))  ## Plot with 2 panels

#Custom panel function
xyplot(y ~ x | f, panel = function(x, y, ...) {
  panel.xyplot(x, y, ...)  ## First call the default panel function for 'xyplot'
  panel.abline(h = median(y), lty = 2)  ## Add a horizontal line at the median
})

#Custom panel function - regression line
xyplot(y ~ x | f, panel = function(x, y, ...) {
  panel.xyplot(x, y, ...)  ## First call default panel function
  panel.lmline(x, y, col = 2)  ## Overlay a simple linear regression line
})



##ggplot2
#Plots are made of aesthe4cs (size, shape, color) and geoms (points, lines)
#Factors are important for indica:ng subsets of the data (if  they  are  to  have  different  proper:es);
#they should be labeled

Modifying aesthetics
qplot(displ, hwy, data = mpg, color = drv)

# To set aesthetics to a particular value, you need
# to wrap that value in I()
qplot(price, carat, data = diamonds, colour = I("blue"))
qplot(carat, price, data = diamonds, alpha = I(1/100))



Adding a geom
qplot(displ, hwy, data =mpg, geom = c("point", "smooth"))

# There are two ways to add additional geoms
# 1) A vector of geom names:
qplot(price, carat, data = diamonds,
      geom = c("point", "smooth"))
# 2) Add on extra geoms
qplot(price, carat, data = diamonds) + geom_smooth()
# This is how you get help about a specific geom:
# ?geom_smooth



Histograms
qplot(hwy, data = mpg, fill =  drv)

qplot(carat, data = diamonds, binwidth = 0.1)
resolution(diamonds$carat)
last_plot() + xlim(0, 3)
# Note that this type of zooming discards data
# outside of the plot regions. See
# ?coord_cartesian() for an alternative



Aesthetics
Using aesthetics creates pretty, but ineffective, plots.
qplot(depth, data = diamonds, binwidth = 0.2, fill = cut) + xlim(55, 70)


Facets
qplot(displ, hwy, data = mpg,  facets = . ~ class)
qplot(displ, hwy, data = mpg) + facet_grid(~ class)
qplot(displ, hwy, data = mpg) + facet_wrap(~ class)


geom density
qplot(log(eno), data = maacs,geom =  "density",color= mopos)


shape vs color
qplot(log(pm25), log(eno), data = maacs, shape = mopos)
qplot(log(pm25), log(eno), data = maacs, color = mopos)


scatterplots
qplot(log(pm25), log(eno), data = maacs, color = mopos, geom = c("point", "smooth"), method = "lm")

qplot(log(pm25), log(eno), data = maacs, geom = c("point", "smooth"), method = "lm", facets = . ~ 
        mopos)


Watch out!
qplot(reorder(class, hwy), hwy, data = mpg, geom = "point")
reorder
qplot(reorder(class, hwy), hwy, data = mpg, geom = "jitter")


grouping
# Need to specify grouping variable: what determines
# which observations go into each boxplot
qplot(table, price, data = diamonds,
      geom = "boxplot", group = round_any(table, 1)) +
  xlim(50, 70)




# Instead of displaying count on y-axis, display density
# .. indicates that variable isn't in original data
qplot(price, ..density.., data = diamonds, binwidth = 500,
      geom = "freqpoly", colour = cut)

Idea            ggplot
Small points   shape = I(".")
Transparency    alpha = I(1/50)
Jittering       geom = "jitter"
Smooth curve    geom = "smooth"
2d bins         geom = "bin2d" or  geom = "hex"
Density contours geom = "density2d"
Boxplots        geom = "boxplot" + group = ...






Basic Components of a ggplot2 Plot
•  A data frame
•  aesthe/c mappings: how data are mapped to color, size
•  geoms: geometric objects like points, lines, shapes.
•   facets: for condi:onal plots.
•  stats: sta:s:cal transforma:ons like binning, quan:les, smoothing.
•  scales: what scale an aesthe:c map uses (example: male = red, female = blue).
•  coordinate system




g <- ggplot(maacs, aes(logpm25, NocturnalSympt))
g + geom_point()

#addin more layers
g + geom_point() + geom_smooth(method = "lm”)


g + geom_point() + facet_grid(. ~ bmicat) + geom_smooth(method = "lm")


Annota:on
•  Labels: xlab(), ylab(), labs(), gg:tle()
•  Each of the “geom” func:ons has op:ons to modify
•  For things that only make sense globally, use theme()
– Example: theme(legend.posi:on = "none")
•  Two standard appearance themes are included
– theme_gray(): The default theme (gray background)
– theme_bw(): More stark/plain

modifying asthetics
g + geom_point(color = "steelbue”, size = 4, alpha = 1/2)

g + geom_point(aes(color = bmicat), size = 4, alpha = 1/2)

Modifying Labels
g + geom_point(aes(color = bmicat)) + labs(title = "MAACS Cohort") + labs(x = expression("log "
* PM[2.5]), y = "Nocturnal Symptoms")


Customizing the smoot
g + geom_point(aes(color = bmicat), size = 2, alpha = 1/2) +
  geom_smooth(size = 4, linetype = 3, method = "lm", se = FALSE)

Changing the Theme
g + geom_point(aes(color = bmicat)) + theme_bw(base_family = "Times”)

A Notes about Axis Limits
g + geom_line() + coord_cartesian(ylim = c(-3, 3))
















####
 
 qplot(displ,hwy, colour = class, data=mpg) + facet_grid(. ~ cyl)
> qplot(displ,hwy, colour = class, data=mpg) + facet_grid(drv ~ cyl)
> qplot(displ,hwy, colour = class, data=mpg) + facet_grid(drv ~ .)


 qplot(reorder(class,hwy),hwy, colour = class, data=mpg,geom="jitter")
 
 
 
 qplot(depth, data = diamonds, binwidth = 0.2, fill = cut) + xlim(55, 70)
 qplot(depth, data = diamonds, binwidth = 0.) + xlim(55, 70) + facet_wrap(~ cut)
 





