################################################################################
#    &&&....&&&    % BioMed 2023: Learning R Course in Summer of 2023          #            #
#  &&&&&&..&&&&&&  % Teacher: Bo Li, Mingwei Liu                               #
#  &&&&&&&&&&&&&&  % Date: Aug. 12th, 2023                                      #
#   &&&&&&&&&&&&   %                                                           #
#     &&&&&&&&     % Environment: R version 4.2.3;                             #
#       &&&&       % Platform: x86_64-w64-mingw32/x64 (64-bit)                 #
#        &         %                                                           #
################################################################################

################################################################################
### code chunk number 11: Loops and Control Flow in R.
################################################################################

### ****************************************************************************
### Step-01. Batch processing in R.

# (1) Using apply() and other functions from apply family. 

# define a function: y = x^2

y <- function(x) {
  return(x^2)
}

system.time({
  res <- lapply(1:5000000, y)
})

# (2) Parallel Computing in R.
# 1) Using parallel package

library(parallel)

clnum <- detectCores()

cl <- makeCluster(getOption("cl.cores", clnum))

cl

system.time({
  res <- parLapply(cl, 1:5000000, y)
})

stopCluster(cl)

# 2) using foreach package. 

# 导入 foreach 包
library(foreach)

# 创建一个需要并行计算的任务，例如计算一组数字的平方和
numbers <- 1:5000000

# 设置并行计算的参数，这里使用 "doParallel" 和 4 个处理器核心
library(doParallel)
registerDoParallel(cores = 4)

# 使用 foreach 循环并行计算
system.time({
  result <- foreach(i = numbers) %dopar% {
    # 在每个迭代中执行的任务
    i^2
  }
})

# 结果是一个向量，包含了每个数字的平方
print(result)

# 关闭之前建立的集群
stopImplicitCluster()

### End of Step-01.
### ****************************************************************************

### ****************************************************************************
### Step-02. Loop in R. 

# A. for ... 

v <- LETTERS[1:4]
for ( i in v) {
  print(i)
}

# (1) The primary method

fun <- function(x) {
  return(x + 1)
}

system.time({
  for (i in 1:5000000) {
    fun(i)
  }
})

# (2) The second method, using foreach package.

# 1) The simplest mode: like lapply(), not parallel computing. 

foreach(a=1:3, b=rep(10, 3)) %do% {
  a + b
}

foreach(i=1:4, .combine="cbind") %do% rnorm(4)

cfun <- function(a, b) a+b
foreach(i=1:4, .combine="cfun") %do% rnorm(4)

# B. repeat ... 

v <- c("Google","Runoob")
cnt <- 2

repeat {
  print(v)
  cnt <- cnt+1
  
  if(cnt > 5) {
    break
  }
}


repeat {
  # 提示用户输入
  input <- readline("请输入一个数字（输入 q 退出）：")
  
  # 检查用户输入是否为 "q"，如果是则跳出循环
  if (input == "q") {
    print("感谢使用！")
    break
  }
  
  # 尝试将用户输入转换为数字
  number <- as.numeric(input)
  
  # 检查是否成功将输入转换为数字
  if (!is.na(number)) {
    # 输入为数字，进行相应的处理
    print(paste("您输入的数字为：", number))
  } else {
    # 输入不是数字，提示用户重新输入
    print("输入无效，请重新输入！")
  }
}


# C. while ... 

v <- c("Google","Runoob")
cnt <- 2

while (cnt < 7) {
  print(v)
  cnt = cnt + 1
}

# D. controlling loop with break()

v <- c("Google","Runoob")
cnt <- 2

repeat {
  print(v)
  cnt <- cnt+1
  
  if(cnt > 5) {
    break
  }
}

# E. controlling loop with next()

v <- LETTERS[1:6]
for ( i in v) {
  
  if (i == "D") { # D 不会输出，跳过这次循环，进入下一次
    next
  }
  print(i)
}

### End of Step-02.
### ****************************************************************************

### ****************************************************************************
### Step-03 Conditional branch statement.

# (1) if ...

# eg-1

x <- 50L
if (is.integer(x)) {
  print("X 是一个整数")
}

# (2) if ... else ...

# eg-1

x <- c("google", "runoob", "taobao")

if ("Runoob" %in% x) {
  print("x 包含 Runoob")
} else {
  print("x 不包含 Runoob")
}

# eg-2

x <- c("google", "runoob", "taobao")

if ("weibo" %in% x) {
  print("第一个 if 包含 weibo")
} else if ("runoob" %in% x) {
  print("第二个 if 包含 runoob")
} else {
  print("没有找到")
}

# (3) switch

# eg-1
x <- switch(
  3,
  "google",
  "runoob",
  "taobao",
  "weibo"
)
print(x)

# eg-2
you.like <- "runoob"
switch(you.like, 
       google = "www.google.com", 
       runoob = "www.runoob.com", 
       taobao = "www.taobao.com")


# 

x <- seq(-2*pi, 2*pi, by = pi/10)
y <- sin(x)


# the first method to define the color sequence
col.seq2 <- ifelse(x <= 0 & y <= 0, "red", "black")

# the second one
col.seq <- rep("black", length(y))
col.seq[x <= 0 & y <= 0] <- "red"
col.seq
plot(x, y, pch = 15, col = col.seq2)


### End of Step-03.
### ****************************************************************************

################################################################################
### End of chunk-11.
################################################################################
