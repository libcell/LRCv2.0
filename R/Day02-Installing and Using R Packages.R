
################################################################################
#    &&&....&&&    % BioMed 2023: Learning R Course in Summer of 2023                       #
#  &&&&&&..&&&&&&  % Teacher: Bo Li, Mingwei Liu                               #
#  &&&&&&&&&&&&&&  % Date: Jul. 18th, 2023                                     #
#   &&&&&&&&&&&&   %                                                           #
#     &&&&&&&&     % Environment: R version 4.2.3;                             #
#       &&&&       % Platform: x86_64-w64-mingw32/x64 (64-bit)                 #
#        &         %                                                           #
################################################################################

################################################################################
### code chunk number 01: Installing & Running R Language.
################################################################################

### ****************************************************************************
### Step-01. Installing R Software. 

# 1) Choosing the CRAN Mirror. 

# For windows. 
# 官方地址：https://cloud.r-project.org/bin/windows/base/
# TUNA 镜像：https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/base/
# USTC 镜像：https://mirrors.ustc.edu.cn/CRAN/bin/windows/base/

# For Linux. 
# 官方地址：https://cloud.r-project.org/bin/linux/
# TUNA 镜像：https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/linux/
# USTC 镜像：https://mirrors.ustc.edu.cn/CRAN/bin/linux/

#  For MacOS. 

# 官方地址：https://cloud.r-project.org/bin/macosx/
# TUNA 镜像：https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/macosx/
# USTC 镜像：https://mirrors.ustc.edu.cn/CRAN/bin/macosx/

# 2) Installing R Software. 

# (i) For Ubuntu version (Linux).
# Using the following shell script.
# sudo apt update
# sudo apt -y upgrade
# sudo apt -y install r-base

# (i) For CentOS version (Linux).
# Using the following shell script.
# sudo yum install R
# R --version

### End of Step-01.
### ****************************************************************************

### ****************************************************************************
### Step-02. About working directory in R. 

# For windows, work directory. 

pri.dir <- getwd()

setwd("D:/00-GitHub/LRCv2.0/tmp/") # setting the working directory. 

### End of Step-02.
### ****************************************************************************

### ****************************************************************************
### Step-02. About working directory in R. 

# For windows, work directory. 

# 查看R所有包的存放目录
.libPaths() 

### End of Step-02.
### ****************************************************************************

### ****************************************************************************
### Step-03. Edit the first script in R. 

myString <- "Hello, World!"

print(myString)

### End of Step-03.
### ****************************************************************************

### ****************************************************************************
### Step-04. Using R as a calculator. 

if (!require(REmap)) {
  library(devtools)
  install_github("lchiffon/REmap")
} 

library(REmap)
map_for_province <- function(x) {
  data <- data.frame(country = mapNames(x), 
                     value = 5 * sample(length(mapCList[[x]])) + 200)
  out <- remapC(data, maptype = x, color = "skyblue")
  return(out)
}

map_for_province("sichuan")

### End of Step-04.
### ****************************************************************************


################################################################################
### End of chunk-01.
################################################################################
