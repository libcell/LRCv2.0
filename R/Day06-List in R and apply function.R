
################################################################################
#    &&&....&&&    % BioMed 2023: Learning R Course in Summer of 2023                       #
#  &&&&&&..&&&&&&  % Teacher: Bo Li, Mingwei Liu                               #
#  &&&&&&&&&&&&&&  % Date: Jul. 29th, 2023                                     #
#   &&&&&&&&&&&&   %                                                           #
#     &&&&&&&&     % Environment: R version 4.2.3;                             #
#       &&&&       % Platform: x86_64-w64-mingw32/x64 (64-bit)                 #
#        &         %                                                           #
################################################################################

################################################################################
### code chunk number 06: Understanding the data objects and their structure.
################################################################################

### ****************************************************************************
### Step-1. List in R

# 1) How to Create Lists in R?

# a) Using list(). 

x <- list(2, 
          LETTERS, 
          1:5, 
          c(FALSE, FALSE, FALSE, TRUE, TRUE))

print(x)

str(x)

# b) Using c().

x1 <- list(10:15)
print(x1)
class(x1)

x2 <- c(x, x1)
print(x2)

x3 <- c(x, 10:15)
print(x3)

x4 <- unlist(x3)

# c() function can combine two or more lists into one as well.

# 2) How to Name R List’s Components?

x
length(x)
str(x)
names(x)
x[[2]][1]

names(x) <- c("WH", "CQ", "CD", "BJ")
x

x$WH; x$CQ

# 3) Indexing a List. 

x

# a) Using logical vectors: extracting sub-list

length(x)
x[[1]]
x[1]

a <- x[[2]]
b <- x[2]
a == b
class(a)
class(b)

x[c(TRUE, FALSE, TRUE, FALSE)]

# b) Using positive integers:

x[c(1, 3)]

# c) Using negative integers:

x[-c(2, 4)]

# d) Using character vectors for named lists:

x[c("WH", "CD")]

# 4) How to Manipulate list in R?

# a) Modifying a component:

x[[1]] <- 5
x[[1]][2] <- 4
x

x[[1]] <- rnorm(10)
x

# b) Adding a new component:

x$GZ <- iris
x

# c) Deleting a component:

x$GZ <- NULL
x

### End of Step-01.
### ****************************************************************************

### ****************************************************************************
### Step-2. apply() in R


### End of Step-02.
### ****************************************************************************

### ****************************************************************************
### Step-3. lapply() in R
### End of Step-03.
### ****************************************************************************

### ****************************************************************************
### Step-4. sapply() in R
### End of Step-04.
### ****************************************************************************

### ****************************************************************************
### Step-5. tapply() in R
### End of Step-05.
### ****************************************************************************

################################################################################
### End of chunk-01.
################################################################################
