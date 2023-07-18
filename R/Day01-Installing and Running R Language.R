
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

setwd("D:/00-GitHub/LRC/tmp/") # setting the working directory. 

### End of Step-02.
### ****************************************************************************

### ****************************************************************************
### Step-02. About working directory in R. 

# For windows, work directory. 

# 查看R软件的相关目录
R.home() 

# 查看R核心包的目录
.Library 

# 查看R核心包的目录和root用户安装包目录
.Library.site 

# 查看R所有包的存放目录
.libPaths() 

# 查看指定包所在的目录
system.file() 

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


### End of Step-04.
### ****************************************************************************

### ****************************************************************************
### Step-05. Using R as a file manager. 

# 相关命令简介
rm(list=ls())
path = 'J:/lab/EX29 --在R语言中进行文件（夹）操作'
setwd(path)

# 创建一个文件A，文件内容是'file A','\n'表示换行，这是一个很好的习惯
cat("file A\n", file="A")

# 创建一个文件B
cat("file B\n", file="B")

file.append("A", "B")  #将文件B的内容附到A内容的后面，注意没有空行

file.create("A")  #创建一个文件A, 注意会覆盖原来的文件

file.append("A", rep("B", 10)) #将文件B的内容复制10便，并先后附到文件A内容后

file.show("A")  #新开工作窗口显示文件A的内容

file.copy("A", "C") #复制文件A保存为C文件，同一个文件夹

dir.create("tmp")  #创建名为tmp的文件夹

file.copy(c("A", "B"), "tmp") #将文件夹拷贝到tmp文件夹中

list.files("tmp")  #查看文件夹tmp中的文件名

unlink("tmp", recursive=F) #如果文件夹tmp为空，删除文件夹tmp

unlink("tmp", recursive=TRUE) #删除文件夹tmp，如果其中有文件一并删除

file.remove("A", "B", "C")  #移除三个文件

# 当前的目录
getwd()

# 查看当前目录的子目录
list.dirs()

# 查看当前目录的子目录和文件。
dir()

# 查看指定目录的子目录和文件。
dir(path="C:/Users/abdata/Desktop/get_pm_data/test")

# 只列出以'pm_2014'开头的子目录或文件
dir(path="C:/Users/abdata/Desktop/get_pm_data", pattern='^pm_2014')

# 列出目录下所有的目录和文件，包括隐藏文件。
dir(path="C:/Users/abdata/Desktop/get_pm_data",all.files=TRUE)

# 查看当前目录的子目录和文件，同dir()函数。
list.files()
list.files(".",all.files=TRUE)

# 查看当前目录权限
file.info(".")

# 查看指定目录权限
file.info("./test")

# 对test目录重命名
file.rename("test", "tmp")

# 查看目录
dir()

# 删除tmp目录
unlink("tmp", recursive = TRUE)
# 查看目录
dir()

# 拼接目录字符串
file.path("test1","test1_1","test1")

dir(file.path("test1","test1_1"))

# 当前目录
getwd()

# 最底层子目录
dirname("C:/Users/abdata/Desktop/get_pm_data/test1/test1_1/test1_2/abdata.txt")

# 最底层子目录或文件名
basename(getwd())
basename("C:/Users/abdata/Desktop/get_pm_data/test1/test1_1/test1_2/abdata.txt")

# 转换~为用户目录
path.expand("~/tmp")

# 检查文件是否存在
file.exists("pm_2014_1.RData")

# 文件不存在
file.exists("pm_2014_1.RData111")

# 查看文件完整信息
file.info("pm_2014_1.RData")

# 查看文件访问权限，存在
file.access("pm_2014_1.RData",0)

# 不可执行
file.access("pm_2014_1.RData",1)

# 可写
file.access("pm_2014_1.RData",2)

# 可读
file.access("pm_2014_1.RData",4)

# 查看一个不存在的文件访问权限，不存在
file.access("pm_2014_1.RData111")

# 判断是否是目录
file_test("-d", "pm_2014_1.RData")
file_test("-d", "test1")

# 判断是否是文件
file_test("-f", "pm_2014_1.RData")
file_test("-f", "test1")

# 创建一个空文件 A.txt
file.create("A.txt")

# 创建一个有内容的文件 B.txt
cat("file B\n", file = "B.txt")
dir()

# 打印A.txt
readLines("A.txt")

# 打印B.txt
readLines("B.txt")

# 合并文件
file.append("A.txt", rep("B.txt", 10))

# 查看文件内容
readLines("A.txt")

# 复制文件
file.copy("A.txt", "C.txt")

# 查看文件内容
readLines("C.txt")

# 修改文件权限，创建者可读可写可执行，其他人无权限
Sys.chmod("A.txt", mode = "0700", use_umask = TRUE)

# 查看文件信息
file.info("A.txt")

# 给文件A.txt重命名为AA.txt
file.rename("A.txt","AA.txt")
dir()

# 硬连接
file.link("readme.txt", "hard_link.txt")

# 软连接
file.symlink("readme.txt", "soft_link.txt")

# 查看文件目录
system("ls -l")

# 删除文件
file.remove("A.txt", "B.txt", "C.txt")
unlink("readme.txt")
system("ls -l")

# 打印硬连接文件
readLines("hard_link.txt")

# 打印软连接文件，soft_link.txt，由于原文件被删除，有错误
readLines("soft_link.txt")

### End of Step-05.
### ****************************************************************************

### ****************************************************************************
### Step-06. Using R as a file downloader. 

url <- "https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/windows/base/R-4.3.1-win.exe"

download.file(url = url, destfile = "R.exe", mode = "wb")

### End of Step-06.
### ****************************************************************************

################################################################################
### End of chunk-01.
################################################################################
