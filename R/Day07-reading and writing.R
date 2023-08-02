################################################################################
#    &&&....&&&    % BioMed 2023: Learning R Course in Summer of 2023                       #
#  &&&&&&..&&&&&&  % Teacher: Bo Li, Mingwei Liu                               #
#  &&&&&&&&&&&&&&  % Date: Aug. 1st, 2023                                      #
#   &&&&&&&&&&&&   %                                                           #
#     &&&&&&&&     % Environment: R version 4.2.3;                             #
#       &&&&       % Platform: x86_64-w64-mingw32/x64 (64-bit)                 #
#        &         %                                                           #
################################################################################

################################################################################
### code chunk number 07: Reading and writing file in R.
################################################################################

### ****************************************************************************
### Step-1. Reading CSV Files. 
xlsx.data <- read.table("D:/test_data.txt", header = TRUE)
print(xlsx.data)
dim(xlsx.data)
class(xlsx.data)
m <- as.matrix(xlsx.data)
class(m)

csv.data <- read.csv("D:/test.csv", header = TRUE)
head(csv.data)
class(csv.data)

xlsx.data == csv.data

csv2.data <- read.table("D:/test.csv", header = TRUE)
dim(csv2.data)

csv3.data <- read.table("D:/test.csv", header = TRUE, sep = ",")
csv3.data
dim(csv3.data)

csv4.data <- read.delim("clipboard", header = TRUE)
dim(csv4.data)
csv4.data

csv5.data <- read.table(file = file.choose(), header = TRUE)
class(csv5.data)

# install.packages("openxlsx")
library(openxlsx)

df <- read.xlsx("D:/test0801.xlsx", sheet = 1)
dim(df)
df
class(df)
write.xlsx(df, "E:/testtable.xlsx")


write.table(df, "E:/newtable2.txt", row.names = FALSE)
write.csv(df, "E:/newtable2.csv", row.names = FALSE)

# 
install.packages("xlsx") # JRE & JDK

library(xlsx)
help(package = "xlsx")

### End of Step-01.
### ****************************************************************************

### ****************************************************************************
### Step-2. Reading XML Files

pkgs <- c("XML", "RCurl")
install.packages(pkgs)

library(XML)
library(RCurl)

url2 <- "http://www.letpub.com.cn/index.php?journalid=6775&page=journalapp&view=detail"
con2 <- getURL(url2)
print(con2)
sink("D:/record.txt")
print(con2)
sink()

tables <- readHTMLTable(con2)
tables

str(tables)

tables[[1]]
tables[[4]]
tables[[5]]

### End of Step-02.
### ****************************************************************************

### ****************************************************************************
### Step-3. Reading JSON Files

library(rvest)
page <- read_html(url)
table_data <- page %>%
  html_nodes("table") %>%
  html_table(fill = TRUE)

for (i in seq_along(table_data)) {
  cat(paste0("Table ", i, ":\n"))
  print(table_data[[i]])
  cat("\n")
}

# 提取其他内容
other_data <- page %>%
  html_nodes("p") %>%
  html_text()

# 输出其他内容
cat("其他内容:\n")
cat(other_data)

# install.paclages("rjson")


### End of Step-03.
### ****************************************************************************

### ****************************************************************************
### Step-4. Reading Excel Files
### End of Step-04.
### ****************************************************************************

### ****************************************************************************
### Step-5. Reading HTML Tables
### End of Step-05.
### ****************************************************************************

################################################################################
### End of chunk-01.
################################################################################
