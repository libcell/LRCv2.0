################################################################################
#    &&&....&&&    % BioMed 2023: Learning R Course in Summer of 2023          #            #
#  &&&&&&..&&&&&&  % Teacher: Bo Li, Mingwei Liu                               #
#  &&&&&&&&&&&&&&  % Date: Sep. 2nd, 2023                                     #
#   &&&&&&&&&&&&   %                                                           #
#     &&&&&&&&     % Environment: R version 4.2.3;                             #
#       &&&&       % Platform: x86_64-w64-mingw32/x64 (64-bit)                 #
#        &         %                                                           #
################################################################################

################################################################################
### code chunk number 17: RNA-seq data analysis in R.
################################################################################

### ****************************************************************************
### Step-01. Preprocessing and preparing the gene expression data. 

### 1) Downloading SRP029880 data from github.  
### After downloading, move them to subdirectory named "data/Exp-data"

### 2) Specifying the path of the expression data. 
counts_file <- "data/Exp-data/SRP029880.raw_counts.tsv"
coldata_file <- "data/Exp-data/SRP029880.colData.tsv"

### 3) Generating gene expression matrix. 
counts <- read.table(counts_file, header = TRUE, sep = '\t')
counts <- as.matrix(counts)
head(counts)
dim(counts)

### A. Computing CPM
summary(counts[, 1:3])
cpm <- apply(subset(counts, select = c(-width)), 2,
             function(x) x/sum(as.numeric(x))*10^6)
summary(cpm[, 1:3])
colSums(cpm)

### B. Computing RPKM
### (i) Preparing the vector containing length for all genes. 
geneLengths <- as.vector(subset(counts, select = c(width)))

### (ii) Counting RPKM values. 
rpkm <- apply(X = subset(counts, select = c(-width)), 
              MARGIN = 2, 
              FUN = function(x) {
                10 ^ 9 * x / geneLengths / sum(as.numeric(x))
                }
              )
rpkm
summary(rpkm[, 1:3])
dim(rpkm) 
colSums(rpkm)

### C. Computing TPM
### 查找基因长度归一化值
rpk <- apply(subset(counts, select = c(-width)), 2,
             function(x)
               x / (geneLengths / 1000))

### 按照基因大小进行RPK标准化
tpm <- apply(rpk, 2, function(x)
  x / sum(as.numeric(x)) * 10 ^ 6)
tpm
summary(tpm[, 1:3])
colSums(tpm)

### End of Step-01.
### ****************************************************************************

### ****************************************************************************
### Step-02. Clustering analysis for gene expression data.  

### 1) 数据方差分析
dim(tpm)
head(tpm)
v <- apply(tpm, 1, var)
v

g1 <- data.frame(case = tpm[1, 1:5], CONT = tpm[1, 6:10])
boxplot(g1, col = 2:3)

g2 <- data.frame(case = tpm[2, 1:5], CONT = tpm[2, 6:10])
boxplot(g2, col = 2:3)

### 2) 利用标准方差整理结果及降序命令挑选前100的基因
selectedgenes <- names(v[order(v, decreasing = T)][1:100])
selectedgenes

### 3) 将结果绘制成热图
# install.packages("pheatmap")
library(pheatmap)
pheatmap(tpm[selectedgenes, ], 
         scale = 'row', 
         show_rownames = FALSE)

### 4) 将结果counts_data绘制成热图
counts_data <- read.table(counts_file, 
                          header = TRUE, 
                          sep = '\t', 
                          stringsAsFactors = TRUE)
pheatmap(counts_data[selectedgenes, -11], 
         scale = 'row', 
         show_rownames = FALSE)

### End of Step-02.
### ****************************************************************************

### ****************************************************************************
### Step-03. Data visualization. 

### 相关性分析及可视化
library(stats)
correlationMatrix <- cor(tpm)
# install.packages("corrplot")
library(corrplot)
corrplot(correlationMatrix,order='hclust',
         addrect=2,addCoef.col='white',
         number.cex=0.7)

## 根据聚类相似度将聚类分成两个
colData <- read.table(coldata_file, 
                      header = TRUE, 
                      sep = '\t',
                      stringsAsFactors = TRUE)
pheatmap(correlationMatrix,
         annotation_col = colData,
         cutree_cols=2)

### End of Step-03.
### ****************************************************************************

### ****************************************************************************
### Step-04. DEG identification. 

### 1) 准备数据：
countData <- as.matrix(subset(counts,select=c(-width)))
colData <- read.table(coldata_file, 
                      header = TRUE, 
                      sep = '\t',
                      stringsAsFactors = TRUE)
designFormula <- " ~ group"

### 2) 利用DESeq进行基因差异性表达分析
library(stats)
library(DESeq2)

### 获取一个有关于以上获得的count data及coldata的DESeq数据集
dds <- DESeqDataSetFromMatrix(countData=countData,
                              colData = colData,
                              design=as.formula(designFormula))
class(dds)
### 打印dds查看其内容
print(dds)

### 将基因中的read进行筛选，将read数少于1的移除
dds <- dds[rowSums(DESeq2::counts(dds))>1,]

### 利用DESeq处理数据
dds <- DESeq(dds)
print(dds)
### 计算差异性，其中“CTRL”作为对照组
DEresults <- results(dds, contrast = c("group",'CASE','CTRL'))
print(DEresults)
### 通过提高p值来整理结果
DEresults <- DEresults[order(DEresults$pvalue),]
print(DEresults)

### 诊断性图像：诊断性检测帮助提升数据的质量、实验系统
### 利用MA plot进行诊断检测，用于观察标准化结果是否良好：大部分散点集中于0轴
library(DESeq2)
DESeq2::plotMA(object = dds, ylim = c(-5, 5))

### p值分布
### 利用图像观察P值分布，观察到峰值和一致的p值分布
library(ggplot2)
ggplot(data = as.data.frame(DEresults), aes(x = pvalue)) +
  geom_histogram(bins = 100)

### PCA plot
#我们需要调取标准化的数据进行绘图，并且对不同的实验使用不同颜色观察聚类效果
library(DESeq2)
countsNormalized <- DESeq2::counts(dds,normalized=TRUE)

### 获取前500的可变基因
selectedGenes <- names(sort(apply(countsNormalized, 1, var),
                            decreasing = TRUE)[1:500])

### DESeq2::plotPCA()来绘出PCA的图像。
rld <- rlog(dds)
DESeq2::plotPCA(rld, ntop = 500, intgroup = 'group') +
  ylim(-50, 50) + theme_bw()

#除了PCA之外，还可以进行RLE帮助找出还需要进行标准化的数据，快速对原始或者
#标准化的数据进行诊断，查看是否需要进一步的处理

# BiocManager::install("EDASeq")
library(EDASeq)
op <- par(mfrow=c(1,2))
plotRLE(countData,outline=FALSE,ylim=c(-4,4),
        col=as.numeric(colData$group),
        main='Raw Counts')

plotRLE(DESeq2::counts(dds,normalized=TRUE),
        outline=FALSE,ylim=c(-4,4),
        col=as.numeric(colData$group),
        mian='Normalized Counts')
par(op)

### 分别提取上调和下调基因
dim(DEresults)
alldegs <- na.omit(DEresults)
dim(alldegs)
up.genes <- alldegs[alldegs$log2FoldChange > 1 & alldegs$padj < 0.05, ]
nrow(up.genes)
updegs <- rownames(up.genes)
down.genes <- alldegs[alldegs$log2FoldChange < -1 & alldegs$padj < 0.05, ]
nrow(down.genes)
downdegs <- rownames(down.genes)

### End of Step-04.
### ****************************************************************************

### ****************************************************************************
### Step-05. Gene set enrichment analysis (GSEA). 

### 1) Identifying DEGs. 

### 基因集富集GO，使用gProfileR 包
library(DESeq2)

### install.packages("knitr")
library(knitr)

### 获取基因差异性分析结果
DEresults <- results(dds,contrast=c('group','CASE','CTRL'))

### 删除基因中的NA空值
DE <- DEresults[!is.na(DEresults$padj),]

### 调整P值<0.1筛选基因
DE <- DE[DE$padj< 0.1,]

### 选择lo2 fold change 大于1的基因
DE <- DE[abs(DE$log2FoldChange)>1,]

### 获取目标基因的列表
genes0fInterest <- rownames(DE)

### 计算GO富集

library(clusterProfiler)
library(org.Hs.eg.db)
data(geneList, package = "DOSE")
gene <- names(geneList)[abs(geneList) > 2]

# Entrez gene ID
head(gene)

ego <- enrichGO(gene          = gene,
                universe      = names(geneList),
                OrgDb         = org.Hs.eg.db,
                ont           = "CC",
                pAdjustMethod = "BH",
                pvalueCutoff  = 0.01,
                qvalueCutoff  = 0.05,
                readable      = TRUE)
head(ego)

library(enrichplot)
barplot(ego, showCategory=20) 
mutate(ego, qscore = -log(p.adjust, base=10)) %>% barplot(x="qscore")

ekg <- enrichKEGG(gene          = gene,
                  organism = "hsa", 
                  keyType = "kegg")
head(ekg)

barplot(ekg, showCategory=10)

updegs
downdegs



gene.df <- bitr(gene, fromType = "ENTREZID",
                toType = c("ENSEMBL", "SYMBOL"),
                OrgDb = org.Hs.eg.db)

ego2 <- enrichGO(gene         = gene.df$ENSEMBL,
                 OrgDb         = org.Hs.eg.db,
                 keyType       = 'ENSEMBL',
                 ont           = "CC",
                 pAdjustMethod = "BH",
                 pvalueCutoff  = 0.01,
                 qvalueCutoff  = 0.05)
head(ego2, 3)                

dotplot(ego, showCategory=30) + ggtitle("dotplot for ORA")
dotplot(ego2, showCategory=30) + ggtitle("dotplot for GSEA")


### Gene-Concept Network

## convert gene ID to Symbol
edox <- setReadable(ego, 'org.Hs.eg.db', 'ENTREZID')
p1 <- cnetplot(edox, foldChange=geneList)
## categorySize can be scaled by 'pvalue' or 'geneNum'
p2 <- cnetplot(edox, categorySize="pvalue", foldChange=geneList)
p3 <- cnetplot(edox, foldChange=geneList, circular = TRUE, colorEdge = TRUE) 
cowplot::plot_grid(p1, p2, p3, ncol=3, labels=LETTERS[1:3], rel_widths=c(.8, .8, 1.2))


### Heatmap-like functional classification
p1 <- heatplot(edox, showCategory=5)
p2 <- heatplot(edox, foldChange=geneList, showCategory=5)
cowplot::plot_grid(p1, p2, ncol=1, labels=LETTERS[1:2])




### -------------------- The first usage, one-by-one ----------------------- ###
library(DOSE)
data(geneList)
de <- names(geneList)[abs(geneList) > 2]

edo <- enrichDGN(de)

library(enrichplot)
barplot(edo, showCategory=20) 

mutate(edo, qscore = -log(p.adjust, base=10)) %>% 
  barplot(x="qscore")


edo2 <- gseDO(geneList)
dotplot(edo, showCategory=30) + ggtitle("dotplot for ORA")
dotplot(edo2, showCategory=30) + ggtitle("dotplot for GSEA")


### Gene-Concept Network
## convert gene ID to Symbol
edox <- setReadable(edo, 'org.Hs.eg.db', 'ENTREZID')
p1 <- cnetplot(edox, foldChange=geneList)
## categorySize can be scaled by 'pvalue' or 'geneNum'
p2 <- cnetplot(edox, categorySize="pvalue", foldChange=geneList)
p3 <- cnetplot(edox, foldChange=geneList, circular = TRUE, colorEdge = TRUE) 
cowplot::plot_grid(p1, p2, p3, ncol=3, labels=LETTERS[1:3], rel_widths=c(.8, .8, 1.2))



p1 <- cnetplot(edox, node_label="category", 
               cex_label_category = 1.2) 
p2 <- cnetplot(edox, node_label="gene", 
               cex_label_gene = 0.8) 
p3 <- cnetplot(edox, node_label="all") 
p4 <- cnetplot(edox, node_label="none", 
               color_category='firebrick', 
               color_gene='steelblue') 
cowplot::plot_grid(p1, p2, p3, p4, ncol=2, labels=LETTERS[1:4])


set.seed(123)
x <- list(A = letters[1:10], B=letters[5:12], C=letters[sample(1:26, 15)])
p1 <- cnetplot(x)

set.seed(123)
d <- setNames(rnorm(26), letters)
p2 <- cnetplot(x, foldChange=d) + 
  scale_color_gradient2(name='associated data', low='darkgreen', high='firebrick')

cowplot::plot_grid(p1, p2, ncol=2, labels=LETTERS[1:2])    

### Heatmap-like functional classification
p1 <- heatplot(edox, showCategory=5)
p2 <- heatplot(edox, foldChange=geneList, showCategory=5)
cowplot::plot_grid(p1, p2, ncol=1, labels=LETTERS[1:2])

### Enrichment Map
edo <- pairwise_termsim(edo)
p1 <- emapplot(edo)
p2 <- emapplot(edo, cex_category=1.5)
p3 <- emapplot(edo, layout="kk")
p4 <- emapplot(edo, cex_category=1.5,layout="kk") 
cowplot::plot_grid(p1, p2, p3, p4, ncol=2, labels=LETTERS[1:4])

### Biological theme comparison
library(clusterProfiler)
data(gcSample)
xx <- compareCluster(gcSample, fun="enrichKEGG",
                     organism="hsa", pvalueCutoff=0.05)
xx <- pairwise_termsim(xx)                     
p1 <- emapplot(xx)
p2 <- emapplot(xx, legend_n=2) 
p3 <- emapplot(xx, pie="count")
p4 <- emapplot(xx, pie="count", cex_category=1.5, layout="kk")
cowplot::plot_grid(p1, p2, p3, p4, ncol=2, labels=LETTERS[1:4])

### UpSet Plot
library(ggupset)
upsetplot(edo)

### ridgeline plot for expression distribution of GSEA result
library(ggridges)
ridgeplot(edo2)


### running score and preranked list of GSEA result
p1 <- gseaplot(edo2, geneSetID = 1, by = "runningScore", title = edo2$Description[1])
p2 <- gseaplot(edo2, geneSetID = 1, by = "preranked", title = edo2$Description[1])
p3 <- gseaplot(edo2, geneSetID = 1, title = edo2$Description[1])
cowplot::plot_grid(p1, p2, p3, ncol=1, labels=LETTERS[1:3])

gseaplot2(edo2, geneSetID = 1, title = edo2$Description[1])
gseaplot2(edo2, geneSetID = 1:3)

gseaplot2(edo2, geneSetID = 1:3, pvalue_table = TRUE,
          color = c("#E495A5", "#86B875", "#7DB0DD"), ES_geom = "dot")

p1 <- gseaplot2(edo2, geneSetID = 1:3, subplots = 1)
p2 <- gseaplot2(edo2, geneSetID = 1:3, subplots = 1:2)

gsearank(edo2, 1, title = edo2[1, "Description"])

### -------------------- The second usage, one-by-one ---------------------- ###


### End of Step-06.
### ****************************************************************************