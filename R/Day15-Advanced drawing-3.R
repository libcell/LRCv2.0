################################################################################
#    &&&....&&&    % BioMed 2023: Learning R Course in Summer of 2023          #            #
#  &&&&&&..&&&&&&  % Teacher: Bo Li, Mingwei Liu                               #
#  &&&&&&&&&&&&&&  % Date: Aug. 26th, 2023                                     #
#   &&&&&&&&&&&&   %                                                           #
#     &&&&&&&&     % Environment: R version 4.2.3;                             #
#       &&&&       % Platform: x86_64-w64-mingw32/x64 (64-bit)                 #
#        &         %                                                           #
################################################################################

################################################################################
### code chunk number 15: Advanced drawing in R.
################################################################################

### ****************************************************************************
### Step-01. About working directory in R. 
# Showing work directory. 
pri.dir <- getwd()
### End of Step-01.
### ****************************************************************************

### ****************************************************************************
### Step-02. Case-1. 

library(ggplot2)
p <- ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) #第一层，画布
print(p)
p + geom_point() #第二层，画散点图

p <-ggplot(mpg, aes(x = cty, y = hwy, color = factor(year)))
p
p + geom_point()

### End of Step-02.
### ****************************************************************************

### ****************************************************************************
### Step-03. Case-3 

p <- ggplot(mpg, aes(x = cty, y = hwy, color = factor(year), size = displ))
p
p + geom_point()

### End of Step-03.
### ****************************************************************************

### ****************************************************************************
### Step-04. Case-4 

p <- ggplot(data = mpg, mapping = aes(x = cty, y = hwy))
p
p <- p + geom_point(aes(colour = factor(year), size = displ))
p
p <- p + stat_smooth()
p
p + scale_color_manual(values = c('blue2', 'red4'))  #增加标度

### End of Step-04.
### ****************************************************************************

### ****************************************************************************
### Step-05. Case-5 
p <- ggplot(data = mpg, mapping = aes(x = cty, y = hwy))
p
p <- p + geom_point(aes(colour = class, size = displ))
p
p <- p + stat_smooth()
p
p <- p + geom_point(aes(colour = factor(year), size = displ))
p
p <- p + scale_size_continuous(range = c(4, 10))  #增加标度
p
p + facet_wrap( ~ year, ncol = 1)     #分面
### End of Step-05.
### ****************************************************************************


### ****************************************************************************
### Step-06. Case-6

p <- ggplot(mpg, aes(x = cty, y = hwy))
p <- p + geom_point(aes(colour = class, size = displ))
p <- p + stat_smooth()
p <- p + scale_size_continuous(range = c(2, 5))
p <- p + facet_wrap( ~ year, ncol = 1)
p <- p + ggtitle('汽车油耗与型号')                   #添加标题
p <- p + labs(y = '每加仑高速公路行驶距离',            #坐标轴修饰
              x = '每加仑城市公路行驶距离')
p <- p + guides(size = guide_legend(title = '排量'),
                #修改图例
                colour = guide_legend(title = '车型', override.aes = list (size =
                                                                           5)))
p

### End of Step-06.
### ****************************************************************************

### ****************************************************************************
### Step-07. Case-7

class2 <- mpg$class                                         # 取出一列
class2 <- reorder(class2, class2, length)            # 排序
mpg$class2 <- class2                                     # 对mpg增加一列
p  <-  ggplot(mpg, aes(x = class2))                    # 画布
p  +  geom_bar(aes(fill = class2))                      # 绘制条形图

### End of Step-07.
### ****************************************************************************

### ****************************************************************************
### Step-08. Case-8

p <- ggplot(mpg, aes(class2, fill = factor(year)))   #分组填充
p  + geom_bar(position = 'identity', alpha = 0.5)

p <- ggplot(mpg, aes(class2, fill = factor(year)))   #分组填充
p  + geom_bar(position = 'dodge', alpha = 0.5)   #

p <- ggplot(mpg, aes(class2, fill = factor(year)))   #分组填充
p + geom_bar(position = 'stack', alpha = 0.5)   #叠加条形图

p <- ggplot(mpg, aes(class2, fill = factor(year)))   #分组填充
p  + geom_bar(position = 'fill', alpha = 0.8)

### End of Step-08.
### ****************************************************************************

### ****************************************************************************
### Step-09. plotly package

library(plotly)
fig <-
  plot_ly(midwest,
          x = ~ percollege,
          color = ~ state,
          type = "box")
fig

### End of Step-09.
### ****************************************************************************

### ****************************************************************************
### Step-10. leaflet package.

library(leaflet)

m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng = 174.768,
             lat = -36.852,
             popup = "The birthplace of R")
m  # Print the map

### End of Step-10.
### ****************************************************************************

### ****************************************************************************
### Step-11. %>% in magrittr package.
# v1
set.seed(123)
n1 <- rnorm(10000)
n2 <- abs(n1) * 50
n3 <- matrix(n2, ncol = 100)
n4 <- round(rowMeans(n3))
hist(n4 %% 7)

# v2
library(magrittr)
set.seed(123)
rnorm(10000) %>%
  abs %>% `*` (50)  %>%
  matrix(ncol=100)  %>%
  rowMeans %>% round %>% 
  `%%`(7) %>% hist
### End of Step-11.
### ****************************************************************************

################################################################################
### End of chunk-15.
################################################################################

