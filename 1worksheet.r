#1(c)
library(ggplot2)
library(gridExtra)
library(knitr)
library(moments)
library(psych)

#1(a,b)
setwd("/Users/ty/Documents/MSDS/MSDS")
getwd()

#1(e)
mydata <- read.csv("abalones.csv")
# View(mydata)

#1(f)
str(mydata)
mydata$VOLUME <- mydata$LENGTH * mydata$DIAM * mydata$HEIGHT
mydata$RATIO <- mydata$SHUCK / mydata$VOLUME

str(mydata)

#1(g)
mydata$SEX <- factor(mydata$SEX, levels = c("I", "M", "F"), labels = c("Infant", "Male", "Female"))
# View(mydata)

#Part 2
summary(mydata)
describeBy(mydata)

sd_output <- aggregate(cbind(VOLUME,HEIGHT,LENGTH,DIAM,RATIO)~SEX,data = mydata,sd)
aggregate(cbind(VOLUME,HEIGHT,LENGTH,DIAM,RATIO)~SEX,data = mydata,mean)
aggregate(cbind(VOLUME,HEIGHT,LENGTH,DIAM,RATIO)~SEX,data = mydata,median)
View(sd_output)

# Worksheet 2
#PART 3
#(a)	(2 point) Consider the table of counts using SEX and CLASS, you created above. Add margins to this table 
# (Hint: There should be 15 cells in this table plus the marginal totals. Apply *table()* first, 
# then pass the table object to *addmargins()* (Kabacoff Section 7.2 pages 144-147)).
# Lastly, present a barplot of these data; ignoring the marginal totals. 
s_cls_table <- table(mydata$CLASS, mydata$SEX)
# numcells <- length(s_cls_table)
#  View(numcells)
 s_cls_margins<- addmargins(s_cls_table)
# View(s_cls_margins)

# barplot
barplot(s_cls_table, beside = TRUE, 
        col = c("blue", "red", "green"), 
        main = "Barplot of SEX and CLASS (Without Marginal Totals)",
        legend = rownames(s_cls_table),
        xlab = "SEX", ylab = "Count")

# **Essay Question (3 points):  Discuss the sex distribution of abalones.  What stands out about the distribution of abalones by CLASS?**
# The barplot shows that Infant abalones are most common, especially in lower classes (A1 and A2), 
# indicating that these classes may correlate with younger abalones. Male abalones are particularly prevalent in CLASS A3,
# which suggesting that this class is associated with maturing males. 
# Female abalones have a more balanced distribution across classes, with slightly higher counts in CLASS A5.Base on it, 
# this pattern suggests that the CLASS categories likely reflect different growth stages, 
# with younger abalones in lower classes and mature abalones in higher ones.

# (b)	(2 points) Using "work", construct a scatterplot matrix of variables 2-6 with *plot(work[, 2:6])* (these are the continuous variables excluding VOLUME and RATIO). The sample "work" will not be used in the remainder of the assignment.
work <-  mydata
#scatterplot
plot(work[, 2:6], 
      main = "Scatterplot Matrix of Variables 2-6", 
      pch = 17, 
      col = "blue")
# **Essay Question (2 points):  Discuss the relationships of the variables in your matrix. What information provides to you if any?

##### Section 4: ( 16 points) Summarizing the data using graphics.***


# (a)  (2 points) Use "mydata" to plot WHOLE versus VOLUME. Color code data points by CLASS.
plot(mydata$VOLUME, mydata$WHOLE, 
     col = as.factor(mydata$CLASS), 
     pch = 17, 
     xlab = "VOLUME", 
     ylab = "WHOLE", 
     main = "WHOLE vs VOLUME by CLASS (Rectangular Approximation)")
legend("topright", legend = unique(mydata$CLASS), col = 1:length(unique(mydata$CLASS)), pch = 17)
# (b)	(2 points) Use "mydata" to plot a histogram of SHUCK and a histogram of WHOLE. Present the two histograms in parallel, the one next to the other 
# and ensure that the y-axis units of the two histograms are the same so you can compare the results. 
# Use title, legend, labels for the axis and different colors. 
# Set up a 1x2 plotting layout for side-by-side histograms
par(mfrow = c(1, 2))

# Histogram for SHUCK
hist(mydata$SHUCK, 
     col = "pink", 
     main = "Histogram of SHUCK", 
     xlab = "SHUCK", 
     ylab = "Frequency", 
     ylim = c(0, 120),
     border = "black")
legend("topright", legend = "SHUCK", fill = "pink", border = "black")

# Histogram for WHOLE
hist(mydata$WHOLE, 
     col = "purple", 
     main = "Histogram of WHOLE", 
     xlab = "WHOLE", 
     ylab = "Frequency", 
     ylim = c(0, 120),  
     border = "black")
legend("topright", legend = "WHOLE", fill = "purple", border = "black")

# Reset to default(layout)
# par(mfrow = c(1, 1))



# (c)	(2 points) Use "mydata" to plot a boxplot of SHUCK and a boxplot of WHOLE. Present the two histograms in parallel, the one next to the other, 
# and ensure that the y-axis units of the two boxplots are the same so you can compare the results. Use title, legend,
# labels for the axis, and different colors. 
# Set up a 1x2 plotting layout for side-by-side boxplots
par(mfrow = c(1, 2))

# Boxplot for SHUCK
boxplot(mydata$SHUCK, 
        col = "yellow", 
        main = "Boxplot of SHUCK", 
        ylab = "Weight", 
        ylim = c(0, 180), 
        names = "SHUCK") 
legend("topright", legend = "SHUCK", fill = "yellow", border = "black")

# Boxplot for WHOLE
boxplot(mydata$WHOLE, 
        col = "red", 
        main = "Boxplot of WHOLE", 
        ylab = "Weight", 
        ylim = c(0, 180),  
        names = "WHOLE")
legend("topright", legend = "WHOLE", fill = "red", border = "black")

# Reset plotting layout to default
# par(mfrow = c(1, 1))


# (d)	(2 points) Now, plot parallel vertical boxplots of SHUCK by SEX. You should have three boxplots in one graph. Change the colors, titles, legends etc…
# Boxplot of SHUCK by SEX
boxplot(SHUCK ~ SEX, data = mydata, 
        col = c("pink", "orange", "purple"), 
        main = "Boxplot of SHUCK by SEX", 
        xlab = "SEX", 
        ylab = "SHUCK Weight")
legend("topright", 
       legend = levels(mydata$SEX), 
       fill = c("pink", "orange", "purple"), 
       title = "SEX")

# (e)	(2 points) And finally plot parallel vertical boxplots of SHUCK by CLASS. You should have three boxplots in one graph. Change the colors, titles, legends etc…
# Boxplot of SHUCK by CLASS
class_colors <- c("skyblue", "lightgreen", "salmon", "gold", "violet")
boxplot(SHUCK ~ CLASS, data = mydata, 
        col = class_colors,
        main = "Boxplot of SHUCK by CLASS", 
        xlab = "CLASS", 
        ylab = "SHUCK Weight")
legend("topright", 
       legend = sort(unique(mydata$CLASS)), 
       fill = class_colors, 
       title = "CLASS")

# (f)	(4 points) Now, let’s compare SHUCK and WHOLE. Use "mydata" to plot SHUCK versus WHOLE with WHOLE on the horizontal axis. Color code data points by CLASS.
#  As an aid to interpretation, determine the maximum value of the ratio of SHUCK to WHOLE.  
#  Add to the chart a straight line with zero intercept using this maximum value as the slope of the line. 
#  If you are using the 'base R' *plot()* function, you may use *abline()* to add this line to the plot. Use *help(abline)* in R to determine the coding for the slope
#  and intercept arguments in the functions. If you are using ggplot2 for visualizations, *geom_abline()* should be used.
# Define colors and ensure they match the CLASS levels
class_colors <- c("skyblue", "lightgreen", "salmon", "gold", "violet")
class_levels <- sort(unique(mydata$CLASS))
color_mapping <- setNames(class_colors, class_levels)

plot(mydata$WHOLE, mydata$SHUCK, 
     col = color_mapping[mydata$CLASS], 
     pch = 19, 
     xlab = "WHOLE", 
     ylab = "SHUCK", 
     main = "SHUCK vs WHOLE by CLASS")

legend("topleft", legend = class_levels, col = class_colors, pch = 19, title = "CLASS")

# cal the maximum
max_ratio <- max(mydata$SHUCK / mydata$WHOLE, na.rm = TRUE)
abline(a = 0, b = max_ratio, col = "red", lty = 2, lwd = 2)

# ***### Section 5: (15 points) Getting insights about the data using graphs.***

# (a)	(6 points) Use "mydata" to create a multi-figured plot with histograms, boxplots and Q-Q plots of RATIO differentiated by sex. This can be done using *par(mfrow = c(3,3))* and base R or *grid.arrange()* and ggplot2. The first row would show the histograms, the second row the boxplots and the third row the Q-Q plots. Be sure these displays are legible.  


par(mfrow = c(3, 3))

# Define unique SEX categories
sex_levels <- unique(mydata$SEX)
colors <- c("skyblue", "lightgreen", "salmon")

# Loop through each SEX category for Histograms, Boxplots, and Q-Q Plots
for (i in 1:length(sex_levels)) {
  sex <- sex_levels[i]
  subset_data <- mydata[mydata$SEX == sex, ]
  
  # 1st Row: Histograms of RATIO by SEX
  hist(subset_data$RATIO, 
       main = paste("Histogram of RATIO -", sex), 
       xlab = "RATIO", 
       col = colors[i], 
       border = "black")
  
  # 2nd Row: Boxplots of RATIO by SEX
  boxplot(subset_data$RATIO, 
          main = paste("Boxplot of RATIO -", sex), 
          ylab = "RATIO", 
          col = colors[i])
  
  # 3rd Row: Q-Q Plots of RATIO by SEX
  qqnorm(subset_data$RATIO, 
         main = paste("Q-Q Plot of RATIO -", sex), 
         col = colors[i])
  qqline(subset_data$RATIO, col = "red", lwd = 2)  # Add Q-Q line for reference
}


# Define unique SEX categories
sex_levels <- unique(mydata$SEX)

for (sex in sex_levels) {
  subset_data <- mydata$RATIO[mydata$SEX == sex]
  
  outliers <- boxplot.stats(subset_data)$out
  
  cat("Outliers for SEX =", sex, ":\n")
  print(outliers)
  cat("\n")
}


