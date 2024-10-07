---
title: "Data Analysis - Worksheet 1"
author: "Irene Tsapara"
date: "2023-04-24"
output:
  pdf_document: default
  html_document: default
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Worksheet Week 1 
**Please review the following document which provides useful background information pertinent to this assignment.Data Analysis Project Instruction.pdf**

**Instructions for the first assignment appear in the Rmd template below.The required abalones.csv data are given below.**  

**Save the abalones data on your computer without opening the file in Excel.Do not change the order of the observations in the original file.  If you do, your answers may not correspond to the answer sheet and sample report.**

Part 1
Enter your data into a DataFrame and set up your datatypes and values.
*** Section 0 *** (16 points) 

1. (a)	(2 points) Use the getwd() to find your working directory.
2. (b)	(2 points)Use the setwd(…) to set your working directory, ensure that your R program and your csv file are in the same directory.
3. (c)	(2 points) Import the following packages in your R studio
           ggplot2, gridExtra, psych, knitr, moments
4. (d)	(2 points) Load the "ggplot2", "gridExtra",”psych” and "knitr" packages
5. (e)	(2 points) Read-in the abalones dataset, defining a new data frame, "mydata,"
6. (f)	(2 points) calculate new variables, VOLUME and RATIO.
7. (g)	(2 points) Run str(mydata) and ensure that your data have been read properly. You should expect 1036 observations and 8 variables.
8. (h)	(2 points) Change the values of “SEX”, there are many ways to do this. We will change the levels of SEX from I,M,F to Infant,Male and Female.

**Do not include package installation code in this document. Packages should be installed via the Console or 'Packages' tab. You will also need to download the abalones.csv from the course site to a known location on your machine.**

```{r Part 1}
#Hints:
#1.	Load the ggplot2 and gridExtra packages.
#a.	library(ggplot2)
#b.	library(gridExtra)
#c.	library(knitr)
#d.	library(moments)
#e.	library(psych)


setwd("/Users/ty/Documents/MSDS/MSDS")
getwd()

library(ggplot2)
library(gridExtra)
library(knitr)
library(moments)
library(psych)

mydata <- read.csv("abalones.csv")

str(mydata)
mydata$VOLUME <- mydata$LENGTH * mydata$DIAM * mydata$HEIGHT
mydata$RATIO <- mydata$SHUCK / mydata$VOLUME

str(mydata)

mydata$SEX
mydata$SEX <- factor(mydata$SEX, 
                     levels = c("I", "M", "F"), 
                     labels = c("Infant", "Male", "Female"))
mydata$SEX
```


```{r Part 1 Readings}
#2.	Use read.csv() to read the abalones.csv into R, assigning the data frame to "mydata."
#a.	mydata <- read.csv("abalones.csv", sep = ",", stringsAsFactors = TRUE)
#b.	The reason we use the separator as “,” is due to the way we have created the csv file with , separators.
#c.	Another important parameter for the read.csv is header, header is by default TRUE, and this is why you can omit it here.
#d.	When the header is “FALSE” then the first line of the file will be read as an observation, otherwise, the values are assigned to Columns names. The columns of the dataframe are called variables.
#3.	The parameter stringsAsFactors = TRUE, changes the datatype of the Character variables to Factors ( Categorical Variables).
```

```{Part 1 New Variables}
#4.	Use the str() function to verify the structure of "mydata." You should have 1036 observations of eight variables.
#5.	Define two new variables, VOLUME and RATIO. Use the following statements to define VOLUME and
#6.	RATIO as variables appended to the data frame "mydata."

mydata$VOLUME <- mydata$LENGTH * mydata$DIAM * mydata$HEIGHT
mydata$RATIO <- mydata$SHUCK / mydata$VOLUME
```

**7.	Use the function levels(mydata$SEX), you should first run the command to see the order of the levels ( values ), then create a vector with the new levels, in the correct order. To do this use the c(,,,) and insert the Values: INFANT, MALE, FEMALE, in the right order.**

##Part 2
Review the descriptive statistics.
***##### Section 1: (19 points) Summarizing the data.***

```{r Part 2 Descriptive Statistics part a}
#(a)	(2 points) Use *summary()* to obtain and present descriptive statistics from mydata, specifically the Five-number descriptive.
summary(mydata)
#(b)	(2 points) Use *describeBy()* to obtain all the descriptive statistics.
describeBy(mydata)
```

**(c)	(2 points) Compare the information received in the two steps above. Explain your answer here**

*** Answer ***
Where as both summary() and describeBy() provide descripitive statistics result, they kind of focus on different aspect.

So when using summary(), the output is more like an overview of the whole dataframe. The information contains the
five fundamental measures -- the minimum, maximum, mean, median, and quartiles -- for each variables  that is numerical.
For the measurements or the factors in the dataset, such as the 'SEX' here, summary() result the counts of levels.

Whereas for describeBy(), it will result in a more detailed review of the data. Basically the idea of using describeBy()
is to get the descriptive statistics of the data/one specific variable with spliting it by a grouping variable.
For example, if I use describeBy(mydata, mydataVOLUME), I will get a detailed output which contains the information not
only the five descriptives that summary() can do, but also other info like standard deviation, mad, range, skew, etc. for 
each volume group. Therefore, I could change 'mydataVOLUME' with any other variables to see how each variables perform 
on the data in detail.




**(d) (2 points) Identify which of the variables have the highest dispersion. What does this mean about the specific
characteristic of the abalones?** 

*** Answer ***
As each of the variables has different unit, so it's biased if we only look at the SD or the range observations to determine
the highest dispersion. Therefore, I would identify the variable with highest value of SD/Mean as the one with highest dispersion. So after calculation and comparsion, 'SHUCK' is the one with highest dispersion as it as the highest CV(sd/mean) 
about 0.61 among all the variables.
This feature implies that the weight of abalones's shuck varies relatively a lot compares to other features of abalones. 
In other words, when consider an abalone's weight, the shuck weight is not a good indicator as it may changes a lot from one 
to another.


```{r Part 2 Descriptive Statistics part b}

#(e)	(2 points) Consider the variable that has the highest dispersion and analyze further by SEX. To do this, we will use the function aggregate that allows us to run different functions on subsets of variables that have common characteristics.
#Use the following function
#   aggregate(cbind(VOLUME,WIDTH,LENGTH,DIAMETER,RATIO)~SEX,data = mydata,sd) 
#Repeat the steps for mean and median.
aggregate(cbind(VOLUME,HEIGHT,LENGTH,DIAM,RATIO)~SEX,data = mydata,sd)
aggregate(cbind(VOLUME,HEIGHT,LENGTH,DIAM,RATIO)~SEX,data = mydata,mean)
aggregate(cbind(VOLUME,HEIGHT,LENGTH,DIAM,RATIO)~SEX,data = mydata,median)
```

```{r Part 2 Tables}

#(f)	(2 points) Use *table()* to present a frequency table using CLASS and RINGS. There should be 115 cells in the table you present. 
table(mydata$CLASS,mydata$RINGS)
#(g)	(2 points) Repeat and Create another table() to present a frequency table using CLASS, SEX. Do you see any similarities?
table(mydata$CLASS,mydata$SEX)
#(h)	(2 points) Repeat and Create another table() to present RINGS and SEX.
table(mydata$RINGS,mydata$SEX)
```
*** (g)Answer ***
The resulted table from part(g) is similar to the one from part(f) on the expression of both of the two tables have high frequency numbers on rows for A2 and A3. so in term of distribution, the two tables are similarly tailed distributed.


**Essay Question (3 points):  Briefly discuss the variable types and distributional implications such as potential skewness and outliers.**

*** Answer ***
Bascially, there're two variable types: numerical(quantitative) variables and categorical(qualitative) variables.

Numerical variables can be devided into continuous and discrete;continuous variables are the ones that can take on from a range of values, whereas discrete variables need to be countable.
Similarily, the categorical variables can also be devided into two types: nominal and ordinal variables. The characteristic of ordinal variables is that there's a certain ranking occurs, while for nominal variables, the categories are kind of paratactic, like colors, names.

There're lots of distributional implications -- variance&standard deviation, central tendency, skewness, outliers, etc. Different variable types has different distributional implications. For example, skewness is not applicable for categorical variables, but for numerical, espeically discrete ones, their skewness is often positively skewed. Similarily for outliers, categorical variables generally do not consider outliers as they are all categories, while numerical variable indeed will have outliers and the outliers will significantly affect other implications like  central tendency and standard deviations.
