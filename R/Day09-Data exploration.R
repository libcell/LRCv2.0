################################################################################
#    &&&....&&&    % BioMed 2023: Learning R Course in Summer of 2023          #            #
#  &&&&&&..&&&&&&  % Teacher: Bo Li, Mingwei Liu                               #
#  &&&&&&&&&&&&&&  % Date: Aug. 5nd, 2023                                      #
#   &&&&&&&&&&&&   %                                                           #
#     &&&&&&&&     % Environment: R version 4.2.3;                             #
#       &&&&       % Platform: x86_64-w64-mingw32/x64 (64-bit)                 #
#        &         %                                                           #
################################################################################

################################################################################
### code chunk number 09: Data exploration in R.
################################################################################

### ****************************************************************************
### Step-1. Basic statistics for multi-feature datasets. 

iris
mydata <- iris[, -5]
head(mydata)
r.mean <- apply(mydata, 1, mean)
print(r.mean)

c.mean <- apply(mydata, 2, mean)
c.mean

c.m.s <- apply(mydata[1:50, ], 2, mean)
c.m.s

c.m.ve <- apply(mydata[51:100, ], 2, mean)
c.m.ve

c.m.vi <- apply(mydata[101:150, ], 2, mean)
c.m.vi


a <- as.numeric(mydata[1, ])
b <- as.numeric(mydata[2, ])
cor(a, b)

plot(a, type = "o")
lines(1:4, b, col = 2)
lines(1:4, flower, col = 3, lwd = 2)

flower <- c(3, 4, 4, 5)
cor(a, flower)

class(a)
class(b)
?cor

flower2 <- a/2
cor(a, flower2)

flower.4 <- mydata[1:4, ]

cor(t(flower.4))

cor(t(mydata))

### End of Step-01.
### ****************************************************************************

### ****************************************************************************
### Step-2. Data normalization.

ten.flowers <- iris[sample(1:150, 10), -5]

cm <- apply(ten.flowers, 2, mean)

scale(ten.flowers, center = TRUE, scale = FALSE)

scale(ten.flowers, center = TRUE, scale = TRUE)

# simulated dataset: 30 X 4, students in row, and courses in column

score <- data.frame(Course_1 = runif(30, min = 50, max = 80), 
                    Course_2 = runif(30, min = 30, max = 100), 
                    Course_3 = runif(30, min = 40, max = 70), 
                    Course_4 = runif(30, min = 20, max = 90))

score <- round(score)
range(score$Course_1)
range(score$Course_2)
range(score$Course_3)
range(score$Course_4)

c.score <- round(scale(score, center = TRUE, scale = FALSE))
n.score <- scale(score, center = TRUE, scale = TRUE)
n.score

# max-min normalization

new.x <- (x - min(x))/(max(x) - min(x)) # from 0 to 1. 

score$Course_1 <- round(100*(score$Course_1 - min(score$Course_1))/(max(score$Course_1) - min(score$Course_1)))
score$Course_2 <- round(100*(score$Course_2 - min(score$Course_2))/(max(score$Course_2) - min(score$Course_2)))
score$Course_3 <- round(100*(score$Course_3 - min(score$Course_3))/(max(score$Course_3) - min(score$Course_3)))
score$Course_4 <- round(100*(score$Course_4 - min(score$Course_4))/(max(score$Course_4) - min(score$Course_4)))

range(score$Course_1)
range(score$Course_2)
range(score$Course_3)
range(score$Course_4)
score
### End of Step-02.
### ****************************************************************************

table(iris$Species)
table(iris$Sepal.Length)

?hist
pie(table(iris$Species))
pie(table(iris$Sepal.Length))

### ****************************************************************************
### Step-3. Correlationship analysis. 

### End of Step-03.
### ****************************************************************************

### ****************************************************************************
### Step-4. Principal Component Analysis.
### End of Step-04.
### ****************************************************************************

### ****************************************************************************
### Step-5. Clustering analysis.
### End of Step-05.
### ****************************************************************************

################################################################################
### End of chunk-01.
################################################################################
