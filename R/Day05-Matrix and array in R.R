
################################################################################
#    &&&....&&&    % BioMed 2023: Learning R Course in Summer of 2023                       #
#  &&&&&&..&&&&&&  % Teacher: Bo Li, Mingwei Liu                               #
#  &&&&&&&&&&&&&&  % Date: Jul. 25th, 2023                                     #
#   &&&&&&&&&&&&   %                                                           #
#     &&&&&&&&     % Environment: R version 4.2.3;                             #
#       &&&&       % Platform: x86_64-w64-mingw32/x64 (64-bit)                 #
#        &         %                                                           #
################################################################################

################################################################################
### code chunk number 03: Understanding the data objects and their structure.
################################################################################

### ****************************************************************************
### 

# 1) 1st method for constructing matrix

mat1.data <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)
mat1 <- matrix(mat1.data, nrow = 3, ncol = 3)
print(mat1)
?matrix

mat2 <- matrix(mat1.data, nrow = 3, ncol = 3, byrow = TRUE)
print(mat2)

mat2.data <- 10:18
mat3 <- matrix(mat2.data, ncol = 3)
mat3

# 2) rbind() and cbind()

mat1.data
mat2.data

mat4 <- rbind(mat1.data, mat2.data)
print(mat4)

mat5 <- cbind(mat1.data, mat2.data)
mat5

cbind(mat1.data, 1:3)
cbind(mat1.data, 1:4)
cbind(1:9, 1:5)

# dim(), nrow() & ncol()
dim(mat5)
mat5
nrow(mat5)
ncol(mat5)

dim(mat4)
mat4
dim(mat1.data)

x <- c(2, 3, 5, 9)
x
dim(x) <- c(2, 2)
x

y <- 1:5
names(y) <- letters[1:5]
y

x

# rownames()
rownames(x) <- c("row-1", "row-2")
x
colnames(x) <- c("column-1", "column-2")
x

x[2, 2]

x[2, 1]
x["row-2", "column-1"]

x[1, ]
x["row-1", ]
mat5
mat5[c(1, 3, 4), ]

# 
let <- letters[1:20]
let <- matrix(let, nrow = 5, ncol = 4)
is.matrix(let)
is.character(let)
dim(let)
length(let)

length(mat5)
mean(mat5)
min(mat5)

mean(let)

let[3, 2] <- 5
let
let[3, ] <- c("chongqing", "chengdu")

mat6 <- (mat5 > 10)
is.matrix(mat6)


vec <- 1:36
vec <- array(vec, dim = c(3, 3, 4))
vec

dim(vec)

vec[, , 1]
vec[, , 2]
vec[1, 3, 2]

rname <- c("row-1", "row-2", "row-3")
cname <- paste("column", 1:3, sep = "-")
mname <- paste("layer", 1:4, sep = "-")
named_vec <- array(1:36, 
                   dim = c(3, 3, 4), 
                   dimnames = list(rname, cname, mname))
named_vec

# 1024 * 768
# 1024*768*3

x <- runif(1024*768*3, min = 0, max = 255)

image <- array(x, dim = c(1024, 768, 3))

dim(image)

image[1:10, 1:10, ]

iris
dim(iris)
head(iris)
is.matrix(iris)
is.array(iris)
class(iris)

rownames(iris)
colnames(iris)
summary(mat5)
summary(iris)

iris[4, 3]
iris[1:2, 3]
iris[2, 5]

str(iris)
iris$Species[1:50]
iris$Species[51:100]
iris$Species[101:150]

names(iris)
ncol(iris)
nrow(iris)
length(iris)
length(mat5)

x <- 1:100
head(x, n = 10)
tail(x)

head(iris)
tail(iris)

head(mat5)
tail(mat5)

selected.iris <- iris[iris$Sepal.Length > 6, ]
dim(selected.iris)

selected.iris2 <- iris[iris$Sepal.Length > 6 & iris$Sepal.Width > 3, ]
dim(selected.iris2)

### End of Step-07.
### ****************************************************************************

################################################################################
### End of chunk-01.
################################################################################
