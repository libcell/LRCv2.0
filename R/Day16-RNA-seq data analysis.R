################################################################################
#    &&&....&&&    % BioMed 2023: Learning R Course in Summer of 2023          #            #
#  &&&&&&..&&&&&&  % Teacher: Bo Li, Mingwei Liu                               #
#  &&&&&&&&&&&&&&  % Date: Aug. 28th, 2023                                     #
#   &&&&&&&&&&&&   %                                                           #
#     &&&&&&&&     % Environment: R version 4.2.3;                             #
#       &&&&       % Platform: x86_64-w64-mingw32/x64 (64-bit)                 #
#        &         %                                                           #
################################################################################

################################################################################
### code chunk number 16: RNA-seq data analysis in R.
################################################################################

### ****************************************************************************
### Step-01. Specify the path where the fastq files are stored. 

### Specify the path. 
fastq.dir <- system.file(package = "ShortRead", "extdata/E-MTAB-1147")
files <- list.files(fastq.dir, "fastq.gz", full.names=TRUE)

### End of Step-01.
### ****************************************************************************

### ****************************************************************************
### Step-02. Perform quality checks with the Rqc package 

### Runing QC
library(Rqc)
qcRes <- rqc(path = fastq.dir, 
             pattern = ".fastq.gz", 
             outdir = "report", 
             openBrowser = FALSE)

### Showing input files
knitr::kable(perFileInformation(qcRes))

### End of Step-02.
### ****************************************************************************

### ****************************************************************************
### Step-03. Extract the related checking score from QC report. 

### Per Read Mean Quality Distribution of Files
rqcReadQualityBoxPlot(qcRes)

### Average Quality
rqcReadQualityPlot(qcRes)

### Cycle-specific Average Quality
rqcCycleAverageQualityPlot(qcRes)

### Read Frequency
rqcReadFrequencyPlot(qcRes)

### Heatmap of top represented reads
rqcFileHeatmap(qcRes[[1]])

### Read Length Distribution
rqcReadWidthPlot(qcRes)

### Cycle-specific GC Content
rqcCycleGCPlot(qcRes)

### Cycle-specific Quality Distribution
rqcCycleQualityPlot(qcRes)

### PCA Biplot (cycle-specific read average quality)
rqcCycleAverageQualityPcaPlot(qcRes)

### Cycle-specific Quality Distribution - Boxplot
rqcCycleQualityBoxPlot(qcRes)

### Cycle-specific Base Call Proportion
rqcCycleBaseCallsPlot(qcRes)
rqcCycleBaseCallsLinePlot(qcRes)

### End of Step-03.
### ****************************************************************************

### ****************************************************************************
### Step-04. Generating report after QC running. 

### Processing files
qa <- rqcQA(files, workers=1)

### Generating report
reportFile <- rqcReport(qa)
browseURL(reportFile)

### End of Step-04.
### ****************************************************************************

### ****************************************************************************
### Step-05. Perform quality checks with the ShortRead package. 

library(ShortRead)
qa <- ShortRead::qa(fastq.dir, "fastq.gz", BPPARAM=SerialParam())
browseURL(report(qa))






##较为广泛进行测序质量控制的工具为FASTQC，R中使用fastqcr
library(fastqcr)
#由于不是mac linux系统，所以需进行操作，让fastqcr用于windows系统：
.check_if_unix <<- function() {
  return(NULL)
}

assignInNamespace(".check_if_unix", .check_if_unix, ns = "fastqcr")

#安装fastqcr相关的java工具
fastqc_install()

#获取处理后的结果并将其放在对应的文件夹中(新创一个叫results的文件夹)
fastqcr::fastqc(fq.dir = fastq.dir, qc.dir = "fastqc_results", 
                fastqc.path = "C:/Program Files/FastQC/run_fastqc.bat")

fastqcr::fastqc(fq.dir = fastq.dir, qc.dir = "fastqc_results",  
                fastqc.path = "wsl.exe C:/Program Files/FastQC/run_fastqc.bat")

#进行fastqc分析，读取已处理的报告
qc_report(qc.path = "fastqc_results",
          result.file = "reportFile",preview = TRUE)

qc <- qc_read("fastqc_results/ERRbs127302_1_suet.fastq.gz")
qc

qc_plot(qc,"Per base sequence quality")




#####过滤、去除reads
library(QuasR)
#获取fastq 文件的路径
fastqFiles <- system.file(package = "ShortRead",
                          "extdata/E-MTAB-1147",
                          c("ERR127302_1_subset.fastq.gz",
                            "ERR127302_2_subset.fastq.gz"))
#
outfiles <- paste(tempfile(pattern=c("processed_1_","processed_2_")),
                  ".fastq",sep="")
print(outfiles)
preprocessReads(fastqFiles,outfiles,nBases = 1,
                truncateStartBases = 3,
                Lpattern = "ACCCGGGA",
                minLength = 40)
#报错 找不到处理过的数据文件，并且最后进行过滤也报错。




#### 利用ShortRead函数进行数据处理：读取一个fastq文件，并过滤每个质量分数低于20的读数。
library(ShortRead)
#A 读取fastq文件
fastqFile <-system.file(package = "ShortRead",
                        "extdata/E-MTAB-1147",
                        "ERR127302_1_subset.fastq.gz") 

#B 读取fastq file
fq <- readFastq(fastqFile)
fq

#C  利用矩阵得到每个碱基的质量得分
qPerBase <- as(quality(fq), "matrix")
qPerBase
dim(qPerBase)
DT::datatable(qPerBase)
#D  获取碱基质量得分<20的数量
qcount <- rowSums(qPerBase <= 20)
qcount
#E  得到菲尔德质量评分>=20的reads 数量
fq[qcount == 0]

#F  读写出每个碱基中所有read得分高于20的fastq文件
writeFastq(fq[qcount == 0],
           paste(fastqFile, "Qfiltered", sep="_"))

#G  fastq文件很大，常用的方法是通过片段化逐条读取
## set up streaming with block size 1000，帮助我们顺利读取片段化的reads
f <- FastqStreamer(fastqFile, readerBlockSize = 1000)
f

while (length(fq <- yield(f))) {
  qPerBase = as(quality(fq), "matrix")
  qcount = rowSums( qPerBase <= 20)
  writeFastq(fq[qcount == 0],
             paste(fastqFile, "Qfiltered", sep="_"),
             mode="a")
}
#将ShortRead每一步的过程合起来，设置While循环，调用yield()来遍历所有片段化文件。
#去除<20 reads的基因。




####映射Mapping/aligning reads to the genome举例
library(QuasR)

#A  复制示例的数据到当前的工作目录路径
#文件本身在QuasR包中，从C:/program file放至当前目录dirPath中
file.copy(system.file(package="QuasR", "extdata"),
          ".", recursive=TRUE)

#B  从文件中打开hg19sub.fa并命名
genomeFile <- "extdata/hg19sub.fa"

#C  样本文件中包含了实例名称和fastq文件路径
sampleFile <- "extdata/samples_chip_single.txt"

#D  
proj <- qAlign(sampleFile, genomeFile)
proj




