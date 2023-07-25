
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
### Step-01. Introduction to Vector. 

# 1) usage of c()

x <- c(3, 4, 5, 6, 7)
print(x)

low <- c(1, 2, 3)
length(low)
high <- c(4, 5, 6)
length(high)
sequence <- c(low, high)
sequence
length(sequence)

# 2) named vector 

x <- c('a' = 5, 'b' = 6, 'c' = 7, 'd' = 8, 'e' = 9)
x

x <- c(5, 6, 7, 8)
names(x)

# NA, inf, -inf, NULL, NAN

names(x) <- c('a', 'b', 'c', 'd')
x

# 3) vector with single element

x <- 6; x
class(x)
x <- c(6); x

# 4) the type and length of the vector 

x <- c(3, 4, 5, 6, 7)
typeof(x)
length(x)
class(x)
mode(x)

### End of Step-01.
### ****************************************************************************

### ****************************************************************************
### Step-02. The numeric vectors. 

# 1) integer和double

x <- c(1L, 5L, 2L, 3L)    # 整数型
x <- c(1.5, -0.5, 2, 3)   # 双精度类型，常用写法
x <- c(3e+06, 1.23e2)     # 双精度类型，科学计数法

# 2) usage of seq()

s1 <- seq(from = 0, to = 10, by = 0.5)
s1
length(s1)

s <- seq(0, 10, len = 50)
print(s)

# 3) usage of rep() # repeat

s2 <- rep(x = c(0, 1), times = 3)
s2

s3 <- rep(x = c(0, 1), each = 3)
s3

s3.1 <- rep(x = c(0, 1), each = c(3, 4))
s3.1

sample <- rep(c("control", "experimental"), each = 10)
sample

# c(0, 0, 0, 1, 1, 1, 1) ?

# 4) usage of ":"

s4 <- 0:10  # Colon operator (with by = 1):
s4

s5 <- 10:1
s5

### End of Step-02.
### ****************************************************************************

### ****************************************************************************
### Step-03. Other vectors. 

# 1) the string vector

x <- c("a", "b", "c")    
x <- c('Alice', 'Bob', 'Charlie', 'Dave')    
x <- c("hello", "baby", "I love you!") 

x1 <- c("1", "2", "3")
x2 <- c(1, 2, 3)

# 2) The Boolean vector

x1 <- c(TRUE, TRUE, FALSE, FALSE)
x2 <- c(T, T, F, F)  # Equivalent, but not recommended
x1 == x2
(x1 == x2)
all(x1 == x2)
any(x1 == x2)

# typeof() !!!
x1 <- c(1.0, 2.3, 3.0, 4.0)
x2 <- c(1, 2.2, 3.3, 4.4)
x1 == x2

# 3) The factor vector

four_seasons <- c("spring", "summer", "autumn", "winter")
four_seasons
class(four_seasons)

four_seasons_factor <- factor(four_seasons)
four_seasons_factor
class(four_seasons_factor)

class(sample)
sample2 <- factor(sample)
sample2

four_seasons <- c("spring", "summer", "autumn", "winter")
four_seasons_factor <- factor(four_seasons, 
                              levels = c("summer", "winter", "spring", "autumn")
)
four_seasons_factor
levels(four_seasons_factor)
### End of Step-03.
### ****************************************************************************

### ****************************************************************************
### Step-04. Extracting the specific elements from the vector. 

# 1) using the positive integer

x <- c(1.1, 2.2, 3.3, 4.4, 5.5) # 秩
print(x)
x[1]
x[3]
x[c(1, 3)]

# 2) using the negative integer

x[-c(2:5)]

# 3) using the logical vector

label <- c(TRUE, FALSE, FALSE, FALSE, FALSE)
x[label]

# 把x中等于3.3的元素提取出来，命名为z
x[x == 3.3]

x[x > 3]

# 4) for named vector

y <- c("a" = 11, "b" = 12, "c" = 13, "d" = 14)
y

y[c("d", "c", "a")]

### End of Step-04.
### ****************************************************************************

### ****************************************************************************
### Step-05. randomly generating numbers in R. 

# 1) random numbers from normal distribution. 

set.seed(1)
x <- rnorm(100, 10, 2)
hist(x, freq=FALSE, main=expression(N(0,2^2)))
curve(dnorm(x, 10, 2), 4, 16, lwd=2, col="red", add=TRUE)

# 正态分布随机数
muv <- c(10, 10, 20)
sdv <- c(1, 2, 1)
np <- 200
x <- seq(0, 30, length.out=np)
ym <- matrix(0, nrow = np, ncol = 3)
for (j in 1:3){
  ym[, j] <- dnorm(x, muv[j], sdv[j])
}
matplot(x, ym, type="l", lwd=2, xlab="x", ylab="f(x)", main="Normal Densities")

# 2) 二项分布随机数
par(mfrow=c(1,3))
p=0.25
for ( n in c(10,20,50)) { 
  x=rbinom(100,n,p)
  hist(x,prob=T,main=paste("n =",n))
  xvals=0:n
  points(xvals,dbinom(xvals,n,p),type="h",lwd=3)
}
par(mfrow=c(1,1))

### End of Step-05.
### ****************************************************************************

### ****************************************************************************
### Step-06. Some cases for vector in R. 

# 1) Student-t test. 
x.c <- rnorm(10, 10, 2)
x.e <- rnorm(10, 15, 0.4)
res <- t.test(x = x.c, y = x.e)
print(res)
res$p.value < 0.05

# 2) Conditional plotting. 
# 
x <- seq(-2*pi, 2*pi, by = pi/20)
y <- sin(x)
plot(x, y)

col.seq <- rep(NA, length(x))
col.seq[x < 0] <- "green"
col.seq[x >= 0] <- "red"

plot(x, y, col = col.seq, pch = 15)

abline(v = 0)
abline(h = 0)
### End of Step-06.
### ****************************************************************************

### ****************************************************************************
### Step-07. 获取对象的属性. 

mode() # 用于获取对象的存储模式
attributes() # 用于获取对象的各种属性
class() # 用于获取对象的类别（或数据类型）

### End of Step-07.
### ****************************************************************************

### ****************************************************************************
### Step-08. Statistics for vector. 

# 10 basic statistical indicators

length(x)
class(x)

mean(x)
median(x)
sum(x)
min(x); which.min(x)
max(x); which.max(x)
range(x)
var(x)
sd(x)
quantile(x); summary(x); fivenum(x)
table(x)

z <- c(rep("A", 4), rep("B", 6))
table(z)
table(sample)

### End of Step-07.
### ****************************************************************************

################################################################################
### End of chunk-01.
################################################################################
