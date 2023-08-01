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

# install.packages("openxlsx")
library(openxlsx)

df <- read.xlsx("D:/test0801.xlsx", sheet = 1)
dim(df)
df
class(df)
write.xlsx(df, "E:/testtable.xlsx")


write.table(df, "E:/newtable2.txt", row.names = FALSE)
write.csv(df, "E:/newtable2.csv", row.names = FALSE)
### End of Step-01.
### ****************************************************************************

### ****************************************************************************
### Step-2. Reading XML Files

### End of Step-02.
### ****************************************************************************

### ****************************************************************************
### Step-3. Reading JSON Files

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
