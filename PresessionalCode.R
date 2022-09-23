# DAY 1 CODE
# ------------------------------------------------------------------------------
# variables
# ------------------------------------------------------------------------------
# Note that blocks of code are grouped together and separated by spaces

rm(list=ls()) # remove all variables from the environment

todayTemp <- 34 # store a single number in a variable

temps <- c(34,24) # an array with two numbers
temps[1] # use indexing to get the first number in the array
temps[2] # use indexing to get the second number in the array

temps <- 20:30 # create a list of numbers that goes from 20 to 30
temps[1] + temps[2] # add the first and second number of this array together
(temps[1]+temps[2]) / 6 # do some arithmetic

profs <- c("Sullivan", "Li", "Kappes") # a string array of profs
profs[1] # first prof in the array

theSkyIsBlue <- TRUE # a different type of variable - a logical variable


# ------------------------------------------------------------------------------
# functions
# ------------------------------------------------------------------------------

rm(list=ls()) # remove all variables from the environment

# what is a function?
temp <- c(34, 33, 28, 25, 24, 24, 24) # create a list of high temperatures
mean(temp) # get the mean of that list of temperatures
help(mean) # get help on this function
example(mean) # see an example use of the function


# DAY 2 CODE
# ------------------------------------------------------------------------------
# Data Frames
# ------------------------------------------------------------------------------

rm(list=ls()) # remove all variables from the environment

# get a built-in data set about cars - note that this won't work because we have 
# not loaded ggplot2 yet!
car <- ggplot2::mpg

library("tidyverse")

# get a built-in data set about cars
car <- ggplot2::mpg

view(car)

# more indexing - three ways to do the same thing
# get just the FIRST COLUMN (car manufacturer)
car[[1]] 
car[,1]
car$manufacturer

# still more indexing - three ways to do the same thing
# get the second observation from the first column
car[[1]][2]
car[2,1]
car$manufacturer[2]

# another example - get the first three years
car$year[1:3]

# get a statistical summary of the data frame
summary(car)

# plot how many of each car manufacturer are in this data set
ggplot(data = car) + # tell ggplot what data frame to plot from
     geom_bar(mapping = aes(factor(manufacturer))) + # set bar graph, with manufact. as factor
     theme(text = element_text(size=20)) # set the font size

# look at the distribution of city mileage across all cars in the data set
ggplot(data = car) + # tell ggplot what data frame to plot from
     geom_histogram(mapping = aes(x=cty), binwidth=2, color=2) + # tell it the type of plot, what variable, and settings
     theme(text = element_text(size = 20)) # set the font size

# Explore relationship between city and highway miles
ggplot(data = car) + # tell ggplot what data frame to plot from
     geom_point(mapping = aes(x = cty, y = hwy)) + # tell it the type of plot, and settings
     theme(text = element_text(size = 20)) # set the font size

# Explore relationship between city and highway miles, coloring each dot by manufacturer
ggplot(data = car) + # tell ggplot what data frame to plot from
     geom_point(mapping = aes(x = cty, y = hwy, color = manufacturer)) + # tell it the type of plot, and settings
     theme(text = element_text(size = 20)) # set the font size

# ------------------------------------------------------------------------------
# for loops
# ------------------------------------------------------------------------------

rm(list=ls()) # remove all variables from the environment

# a simple for loop:
for (i in 1:10){
     print(i+i)
}

# a for loop that adds i + i
for (i in 1:10){
     print(i+i)
}

# create a list of prices for products:
productPrices <- 9:15

# now add five to each product and print the result:
print(5 + productPrices[1])
print(5 + productPrices[2])
print(5 + productPrices[3])
print(5 + productPrices[4])
print(5 + productPrices[5])
print(5 + productPrices[6])
print(5 + productPrices[7])

# create our new price array that is empty
newprice <- vector(mode="numeric", length=length(productPrices))

# then fill it in with new price information
for (i in 1:length(productPrices)){
     newprice[i] <- productPrices[i] + 5
     print(newprice[i])
}
newprice

# easier way to add five to old prices
newprice <- productPrices + 5


# ------------------------------------------------------------------------------
# if/then statements
# ------------------------------------------------------------------------------

rm(list=ls()) # remove all variables from the environment

productPrices <- 9:15 # create some product prices

# create a new price variable (a.k.a "vector")
newprice <- vector(mode="numeric", length=length(productPrices))

# loop through each product ("i") 
for (i in 1:length(productPrices)){
     
     if (productPrices[i] > 11) { # but ONLY if the product is over $11
          newprice[i] <- productPrices[i] + 5
     } else {
          newprice[i] <- productPrices[i]
     }
}


# ------------------------------------------------------------------------------
# MLB example
# ------------------------------------------------------------------------------

rm(list=ls()) # remove all variables from the environment

# load necessary packages
library("readxl")
library("tidyverse")

# load data set and get it into the right format for analysis
mlbdata <- read_excel("MLB_cleaned.xlsx") # load excel data as a tibble

view(mlbdata) # take a glance at the data

# see summary statistics of the data
summary(mlbdata) # note that this gives you quartile cut-offs and min, max


# plot distribution of MLB player heights, with mean, median, mode indicated
ggplot(mlbdata, aes(x = HeightInch)) + # tell ggplot which variable(s) to plot
     geom_histogram(binwidth = 1, color=1) + # tell it the type of plot, and settings
     geom_vline(aes(xintercept = mean(HeightInch)), linetype = "dashed", color = "red") +
     geom_vline(aes(xintercept = median(HeightInch)), linetype = "solid", color = "black") +
     theme(text = element_text(size = 20)) # set the font size

# create a new data frame without this outlier
mlbNoOutliers <- filter(mlbdata, HeightInch < 200)

# same as above, but exclude the visible height outlier
ggplot(mlbNoOutliers, aes(x = HeightInch)) + # tell ggplot which variable(s) to plot
     geom_histogram(binwidth = 1, color=1) 


# ------------------------------------------------------------------------------
# Below is an example of how to write a variable to a new excel file
# the new excel file will show up in your working directory
# ------------------------------------------------------------------------------
# first, install the package by typing install.packages("writexl")

library("writexl") # load the writexl package

# This writes the no outliers dataframe to an excel spreadsheet:
write_xlsx(mlbNoOutliers, "mlb_noOutliers.xlsx")
