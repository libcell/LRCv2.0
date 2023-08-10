################################################################################
#    &&&....&&&    % BioMed 2023: Learning R Course in Summer of 2023          #            #
#  &&&&&&..&&&&&&  % Teacher: Bo Li, Mingwei Liu                               #
#  &&&&&&&&&&&&&&  % Date: Aug. 10th, 2023                                      #
#   &&&&&&&&&&&&   %                                                           #
#     &&&&&&&&     % Environment: R version 4.2.3;                             #
#       &&&&       % Platform: x86_64-w64-mingw32/x64 (64-bit)                 #
#        &         %                                                           #
################################################################################

################################################################################
### code chunk number 10: PCs, Correlationship & Clustering analysis in R.
################################################################################

### ****************************************************************************
### Step-01. Principal Component Analysis. 

# (1) 3D PCA

# 1) 模拟10000行（10000个基因），100列（100个样本）的基因表达矩阵。

chip.data <- matrix(rnorm(10000*100, mean=0), nrow=10000, ncol=100)
dim(chip.data)
head(chip.data)
rownames(chip.data) <- paste("gene", 1:10000, sep = "-")
colnames(chip.data) <- paste("sample", 1:100, sep = "-")
colnames(chip.data)[1:50] <- paste("healthy", 1:50, sep = "-")
colnames(chip.data)[51:100] <- paste("patient", 1:50, sep = "-")
head(chip.data)

# 2) 在10000个基因中，假定有100个基因在两组间存在差异，前50个上调，另50个下调；

deg.index <- sample(1:10000, 100)
deg.index
chip.data[deg.index[1:50],1:50] <- chip.data[deg.index[1:50],1:50] - 10
chip.data[deg.index[51:100],1:50] <- chip.data[deg.index[51:100],1:50] + 10

# 3) PCA分析
## Default S3 method:
chip.data.pca <- princomp(chip.data)
summary(chip.data)
chip.data <- t(chip.data)
chip.data <- chip.data[, 1:50]
head(chip.data)
chip.pca <- princomp(chip.data)
chip.pca
str(chip.pca)
chip.pca$loadings
# 4) 可视化
colour<-c(rep(2,50),rep(7,50))
library(rgl)
plot3d(chip.pca$loadings[,1:3],col=colour,type="s",radius = 0.025)
plot3d(chip.data.pca$loadings[,1:3],col=colour,type="l",radius = 0.025)

# (2) Alternatively, using pca3d package

rm(list=ls())
library(pca3d)
library(rgl)

data(metabo)
dim(metabo)
metabo[1:6, 1:6]
help(package = "pca3d")
metabo.pca <- prcomp(metabo[,-1], scale.=TRUE)
groups <- factor(metabo[,1])

summary(metabo.pca)

pca3d(metabo.pca, group=groups, show.ellipses=TRUE, elle.ci=0.75, show.plane=FALSE)
pca3d(metabo.pca, group=groups, show.ellipses=TRUE)
pca3d(metabo.pca, group=groups)

### End of Step-01.
### ****************************************************************************


### ****************************************************************************
### Step-02. Correlation-ship analysis. 

# (1) The primary method

x <- iris[,-5]

# 计算协方差
cov(x$Sepal.Length,x$Petal.Length)

cov(x)
#>              Sepal.Length Sepal.Width Petal.Length Petal.Width
#> Sepal.Length    0.6856935  -0.0424340    1.2743154   0.5162707
#> Sepal.Width    -0.0424340   0.1899794   -0.3296564  -0.1216394
#> Petal.Length    1.2743154  -0.3296564    3.1162779   1.2956094
#> Petal.Width     0.5162707  -0.1216394    1.2956094   0.5810063

heatmap(cov(x))
pheatmap::pheatmap(cov(x))

# 计算相关性系数（pearson是参数检验，另外两个为非参数检验。)
cor(x$Sepal.Length,x$Petal.Length, method = "pearson")
#> [1] 0.8717538
cor(x$Sepal.Length,x$Petal.Length, method = "kendall") # rank
#> [1] 0.7185159
cor(x$Sepal.Length,x$Petal.Length, method = "spearman")

cor(x)

pheatmap::pheatmap(cor(x))

cor.test(x$Sepal.Length,x$Petal.Lengt)
cor.test(x$Sepal.Length,x$Petal.Length, method = "kendall")

cor.test(x$Sepal.Length,x$Petal.Length, method = "spearman")

# (2) The second method

data(mtcars)
str(mtcars)#简单看一下数据集
cor(mtcars$disp, mtcars$hp)#简单看一下disp和hp两个变量的相关性

corr<- cor(mtcars)#求所有变量的相关性
corr
library(corrplot)#加载所需要的包
corrplot(corr)

corrplot(corr,method = "ellipse")

corrplot(corr,order="AOE",method="color",addCoef.col="orange")

corrplot.mixed(corr,order="AOE")


# (3) # alternative

library(corrplot)

# 计算相关性
corData = cor(mtcars,
              method = "pearson",            # 计算相关性的方法有"pearson", "spearman", "kendall"
              use = "pairwise.complete.obs") # 缺失值处理的方式
# 计算相关性的P值和置信区间
testRes = cor.mtest(mtcars,
                    conf.level = 0.95,       # 置信区间
                    method = "pearson")      # 计算相关性的方法有"pearson", "spearman", "kendall"

# 绘图
corrplot(corData,
         method = "circle",           # 图案形状 "square"方框,"circle"圆, "ellipse"椭圆, "number"数字, "shade"阴影花纹, "color"颜色方框, "pie饼图"
         type = "full",               # 绘制范围"full"全部, "lower"下半部分, "upper"半部分
         col=colorRampPalette(c('#0000ff','#ffffff','#ff0000'))(100), # 主体颜色
         bg = "white",                # 背景颜色
         # col.lim = c(-1,1),         # 数据颜色的范围，是相关性数据的话，直接is.corr = T就好
         title = "",                  # 标题
         is.corr = T,                 # 输入的矩阵是否是相关性矩阵，如果是的话，数据范围会限制到-1到1
         add = F,                     # 是否在原来的图层上添加图形
         diag = T,                    # 是否显示主对角
         outline = F,                 # 图案的轮廓，True或False或某一颜色值
         mar = c(0, 0, 0, 0),         # 下 左 上 右 边距
         addgrid.col = NULL,          # 网格线的颜色，NA为不绘制，NULl为默认的灰色
         addCoef.col = NULL,          # 当method!="number"时，是否显示相关性数值，显示的颜色
         addCoefasPercent = F,        # 是否把相关性数值改为百分数
         order = "original",          # 排序方式 c("original", "AOE", "FPC", "hclust", "alphabet"), original：原始状态，alphabet：字母顺序 hclust，分层聚类顺序
         hclust.method = c("complete", "ward", "ward.D", "ward.D2", "single", "average","mcquitty", "median", "centroid"), # 当order = "hclust"时，分层聚类的算法
         tl.pos = "lt",               # 坐标轴标签的位置'lt', 'ld', 'td', 'd' or 'n'   # 左边 d中间
         tl.cex = 1,                  # 坐标轴标签字体的大小
         tl.col = "black",            # 坐标轴标签字体的颜色
         tl.offset = 0.4,             # 坐标轴标签离图案的距离
         tl.srt = 90,                 # 坐标轴标签旋转角度
         cl.pos = "r",                # 图例位置：r：右边 b：下边 n：不显示
         cl.length = NULL,            # 数字越大，图例的分隔越稠
         cl.cex = 0.8,                # 图例的字体大小
         cl.ratio = 0.15,             # 图例的宽度
         cl.align.text = "c",         # 图例文字的对齐方式 l左对齐 c居中 r右对齐
         cl.offset = 0.5,             # 图例文字距离图例颜色条的距离 居中时无效
         number.cex = 1,              # 相关性数字标签的字体大小
         number.font = 2,             # 相关性数字标签的字体
         number.digits = 2,           # 相关性数字标签，保留的小数点位数
         na.label = "",               # 当为NA时，显示的内容
         p.mat = testRes$p,           # P值矩阵
         sig.level = 0.05,            # 当p大于sig.level时触发动作
         insig = "pch",               # p值大于sig.level时的方案"pch"图案, "p-value"P值数字, "blank"空白, "n"无操作, "label_sig"星号,
         pch = 4,                     # 当insig = "pch"时的图案形状 4为叉
         pch.col = "black",           # 图案颜色
         pch.cex = 3,                 # 图案大小
         plotCI = "n",                # c("n", "square", "circle", "rect"),  # p值置信区间的方案
         lowCI.mat = testRes$lowCI,   # p值置信区间下边界数据
         uppCI.mat = testRes$uppCI,   # p值置信区间上边界数据
)

### End of Step-02.
### ****************************************************************************

### ****************************************************************************
### Step-03 Clustering analysis.

# (1) HCA: 层次聚类分析

small.iris <- iris[c(sample(1:50, 5), sample(51:100, 5), sample(101:150, 5)), ]
small.iris

x <- t(small.iris[, -5])

corr <- cor(x)

corrplot(corr, order = "AOE")

plot(small.iris$Sepal.Length, small.iris$Sepal.Width, col = small.iris$Species, 
     pch = 15)

plot(small.iris$Sepal.Length, small.iris$Petal.Length, col = small.iris$Species, 
     pch = 15)


# dist

?dist

# 计算样本之间距离
d.iris <- dist(small.iris[, -5], method = "binary")
d.iris
# 样本聚类 
tree <- hclust(d.iris, method = "single")

print(tree)
# 聚类结果的可视化
plot(tree)

scaled.iris <- scale(small.iris[, -5])

boxplot(small.iris[, -5], col = 2:5)

boxplot(scaled.iris, col = 2:5)

library(NbClust)
nc <- NbClust(scaled.iris, distance="euclidean", 
              min.nc=2, max.nc=10, method="average")

# 1) 数据预处理

par(ask=TRUE)
opar <- par(no.readonly=FALSE)
data(nutrient, package="flexclust")   #加载数据包
head(nutrient, 10)
#可以看出energy这一列的数值差异很大，十分影响后几个变量的贡献，因此需要归一化。
nutrient.scaled <- scale(nutrient) 
head(nutrient.scaled, 10)
#这样就舒服很多了

# 2) 计算距离
d <- dist(nutrient.scaled)
#好像dist还是专门的一种储存格式
as.matrix(d)[1:4,1:4]
#局部查看一下 

# 3) 

fit.average <- hclust(d, method="average")
plot(fit.average, hang=-1, cex=.8, main="Average Linkage Clustering")
#绘树状图图，聚类可视化。

# 4) 确定簇的个数
library(NbClust)
nc <- NbClust(nutrient.scaled, distance="euclidean", 
              min.nc=2, max.nc=15, method="average")
#直接返回的结论推荐为2

par(opar)
table(nc$Best.n[1,])
#分别各有四个评判准则赞同聚类个数为2、3、5、15
barplot(table(nc$Best.n[1,]), 
        xlab="Numer of Clusters", ylab="Number of Criteria",
        main="Number of Clusters Chosen by 26 Criteria") 
#将上述结果绘制成柱状图。

# 5) 获取最终聚类方案

clusters <- cutree(fit.average, k=5) 
# 查看k类解决方案的各类观察树木数目
table(clusters)

# 6) 最终可视化
plot(fit.average, hang=-1, cex=.8,  
     main="Average Linkage Clustering\n5 Cluster Solution")
rect.hclust(fit.average, k=5)

# (3) k-means



### End of Step-03.
### ****************************************************************************

################################################################################
### End of chunk-10.
################################################################################
