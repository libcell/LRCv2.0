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

chip.data<-matrix(rnorm(10000*100,mean=0),nrow=10000,ncol=100)
diff.index<-sample(1:1000,1000)

# 2) 在10000个基因中，假定有100个基因在两组间存在差异，前50个上调，另50个下调；
chip.data[diff.index[1:50],1:10]<-rnorm(50*10,mean=2)
chip.data[diff.index[1:50],1:10]<-rnorm(50*10,mean=-2)

# 3) PCA分析
## Default S3 method:
chip.data<-princomp(chip.data)
summary(chip.data)
# 4) 可视化
colour<-c(rep(2,50),rep(7,50))
library(rgl)
plot3d(chip.data.pca$loadings[,1:3],col=colour,type="s",radius = 0.025)
plot3d(chip.data.pca$loadings[,1:3],col=colour,type="l",radius = 0.025)


# (2) Alternatively, using pca3d package

rm(list=ls())
library(pca3d)
library(rgl)

data(metabo)
head(metabo)

metabo.pca <- prcomp(metabo[,-1], scale.=TRUE)
groups  <- factor(metabo[,1])

summary(metabo.pca)

pca3d(metabo.pca, group=groups, show.ellipses=TRUE, elle.ci=0.75, show.plane=FALSE)
pca3d(metabo.pca, group=groups, show.ellipses=TRUE, ellipse.ci=0.75, show.plane=FALSE)

### End of Step-01.
### ****************************************************************************


### ****************************************************************************
### Step-02. Correlation-ship analysis. 

x = iris[,-5]
x2 = state.x77

# 计算协方差
cov(x$Sepal.Length,x$Petal.Length)
#> [1] 1.274315
cov(x)
#>              Sepal.Length Sepal.Width Petal.Length Petal.Width
#> Sepal.Length    0.6856935  -0.0424340    1.2743154   0.5162707
#> Sepal.Width    -0.0424340   0.1899794   -0.3296564  -0.1216394
#> Petal.Length    1.2743154  -0.3296564    3.1162779   1.2956094
#> Petal.Width     0.5162707  -0.1216394    1.2956094   0.5810063
pheatmap::pheatmap(cov(x))

# 计算相关性系数（pearson是参数检验，另外两个为非参数检验。)
cor(x$Sepal.Length,x$Petal.Length)
#> [1] 0.8717538
cor(x$Sepal.Length,x$Petal.Length,method = "kendall")
#> [1] 0.7185159
cor(x$Sepal.Length,x$Petal.Length,method = "spearman")
#> [1] 0.8818981
#> 
#> cor(x)
#>              Sepal.Length Sepal.Width Petal.Length Petal.Width
#> Sepal.Length    1.0000000  -0.1175698    0.8717538   0.8179411
#> Sepal.Width    -0.1175698   1.0000000   -0.4284401  -0.3661259
#> Petal.Length    0.8717538  -0.4284401    1.0000000   0.9628654
#> Petal.Width     0.8179411  -0.3661259    0.9628654   1.0000000
pheatmap::pheatmap(cor(x))

cor.test(x$Sepal.Length,x$Petal.Lengt)
cor.test(x$Sepal.Length,x$Petal.Length,method = "kendall")

cor.test(x$Sepal.Length,x$Petal.Length,method = "spearman")

### End of Step-02.
### ****************************************************************************

### ****************************************************************************
### Step-03 Clustering analysis.
### End of Step-03.
### ****************************************************************************

################################################################################
### End of chunk-10.
################################################################################
