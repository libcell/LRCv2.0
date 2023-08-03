################################################################################
#    &&&....&&&    % BioMed 2023: Learning R Course in Summer of 2023          #            #
#  &&&&&&..&&&&&&  % Teacher: Bo Li, Mingwei Liu                               #
#  &&&&&&&&&&&&&&  % Date: Aug. 3st, 2023                                      #
#   &&&&&&&&&&&&   %                                                           #
#     &&&&&&&&     % Environment: R version 4.2.3;                             #
#       &&&&       % Platform: x86_64-w64-mingw32/x64 (64-bit)                 #
#        &         %                                                           #
################################################################################

################################################################################
### code chunk number 07: Exploring data distribution in R.
################################################################################

### ****************************************************************************
### Step-1. Focusing tendency of the data. 

# 
x <- rnorm(100, mean = 0, sd = 1)

hist(x) # 直方图

lines(density(x), col = 2)

hist(x, probability = TRUE)
lines(density(x), col = 2)

hist(x, breaks = 20, probability = TRUE)
lines(density(x), col = 2, lwd = 3)

# 
mean(x)
sum(x)/length(x)
mean(x) == sum(x)/length(x)

median(x)

which(x == median(x)) ##???

# mode

table(x)

which(table(x) == max(table(x)))

y <- c(2, 2, 4, 4, 4, 5, 5, 5, 8)

table(y)

max(table(y))

which(table(y) == max(table(x)))

a <- max(table(y))


a <- as.numeric(names(table(y))[which(table(y) == 3)])

match(a, y) # 

# quantile in R
?quantile

quantile(x, probs = seq(0, 1, by = 0.1))

print(x)

plot(x, type = "o", main = "raw x values")
plot(sort(x), type = "o", main = "ranked x values, from small to big ones")
ranked.x <- sort(x)
ranked.x
quantile(x)

max(x)
which.max(x)
which(x == max(x))

fivenum(x)

summary(x)

median(x)
mean(x)

x[67] <- 100
x

mean(x)
median(x)

### End of Step-01.
### ****************************************************************************

### ****************************************************************************
### Step-2. Data variations.

x <- rnorm(1000, mean = 1, sd = 1)
var(x)
sd(x)
sd(x)/mean(x) # CV
max(x) - min(x)
range(x)

IQR(x)

quantile(x, probs = 0.75) - quantile(x, probs = 0.25)

boxplot(x)

# 上触须
quantile(x, probs = 0.75) + 1.5*IQR(x)
quantile(x, probs = 0.25) - 1.5*IQR(x)

x[986] <- 90

boxplot(x)

boxplot(iris[, -5], col = 2:5)


install.packages("fBasics")

# skewness()

# kurtosis()


### End of Step-02.
### ****************************************************************************

### ****************************************************************************
### Step-3. Distribution of 2D data. 

### End of Step-03.
### ****************************************************************************

### ****************************************************************************
### Step-4. Data normalization.
### End of Step-04.
### ****************************************************************************

### ****************************************************************************
### Step-5. Others.
### End of Step-05.
### ****************************************************************************

################################################################################
### End of chunk-01.
################################################################################
