################################################################################
#    &&&....&&&    % BioMed 2023: Learning R Course in Summer of 2023          #            #
#  &&&&&&..&&&&&&  % Teacher: Bo Li, Mingwei Liu                               #
#  &&&&&&&&&&&&&&  % Date: Aug. 15th, 2023                                      #
#   &&&&&&&&&&&&   %                                                           #
#     &&&&&&&&     % Environment: R version 4.2.3;                             #
#       &&&&       % Platform: x86_64-w64-mingw32/x64 (64-bit)                 #
#        &         %                                                           #
################################################################################

################################################################################
### code chunk number 12: Loops in R.
################################################################################

### ****************************************************************************
### Step-01. Loop in R. 

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

### End of Step-01.
### ****************************************************************************

### ****************************************************************************
### Step-02 Defining the specific function in R.

# (1) Defining the function by yourself

# eg-1

# (2) The function with parameter value

# (3) The lazy function

# (4) The embedded function

### End of Step-02.
### ****************************************************************************

################################################################################
### End of chunk-12.
################################################################################
