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
#. fastq.dir <- system.file(package = "ShortRead", "extdata/E-MTAB-1147")
#. files <- list.files(fastq.dir, "fastq.gz", full.names=TRUE)

fastq.dir <- "data/E-MTAB-1147"

### End of Step-01.
### ****************************************************************************

### ****************************************************************************
### Step-02. Perform quality checks with the Rqc package 

### Runing QC (Quality Control for RNA-seq raw data)
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
files <- list.files(fastq.dir, "fastq.gz", full.names=TRUE)
qaRpt <- rqcQA(files, workers=1)

### Generating report
reportFile <- rqcReport(qaRpt)
browseURL(reportFile)

### End of Step-04.
### ****************************************************************************

### ****************************************************************************
### Step-05. Perform quality checks with the ShortRead package. 

### -------------------- The first usage, one-by-one ----------------------- ###

library(ShortRead)
qa <- qa(fastq.dir, "fastq.gz", BPPARAM=SerialParam())
browseURL(report(qa))

### -------------------- The second usage, one-by-one ---------------------- ###

#### 读取一个fastq文件，并过滤每个质量分数低于20的读数。

# 1) Getting all files in fastq format.
library(ShortRead)
fqs <- list.files("data/E-MTAB-1147")
fastqFile <- paste("data/E-MTAB-1147", fqs, sep = "/")

# 2) Filtering low-quality reads. 
for (i in 1:length(fqs)) {
  fq.file <- fastqFile[i]
  qualified.fq.file <- paste0("data/E-MTAB-1147/", 
                             "qualified_", fqs[i])
  fq <- readFastq(fq.file)
  fq
  
  # 3) Obtaining the quality score for each fastq file. 
  qPerBase <- as(quality(fq), "matrix")
  qPerBase
  dim(qPerBase)
  # DT::datatable(qPerBase)
  
  # 4) Count the number of bases with a quality score <20
  qcount <- rowSums(qPerBase <= 20)
  qcount
  
  # 5) Extract reads with Field quality score >= 20
  qualified.reads <- fq[qcount == 0]
  
  # 6) Rewrite reads with each-base-score > 20 into a new fastq file
  writeFastq(object = qualified.reads, file = qualified.fq.file, 
             mode = "w", full=FALSE, compress=TRUE)
}

### End of Step-05.
### ****************************************************************************

### ****************************************************************************
### Step-06. Perform read mapping genome. 

### 1) Preparing the fastq, genome and annotation files -------------------- ###

library(QuasR)
file.copy(system.file(package = "QuasR", "extdata"), ".", recursive = TRUE)

### Offering the index of fastq files. 
sampleFile <- "extdata/samples_chip_single.txt"

### Offering the file path of genome sequence file in fasta format.
genomeFile <- "extdata/hg19sub.fa"

### 2) Mapping / aligning reads to genome ---------------------------------- ###

### Alignment was carried out. 
proj <- qAlign(sampleFile, genomeFile, splicedAlignment = FALSE)
proj
alignmentStats(proj)
qQCReport(proj, "extdata/qc_report.pdf")

### 3) Mapping and quantifying gene expression levels ---------------------- ###

### Preparing all files. 
sampleFile <- "extdata/samples_chip_single.txt"
auxFile <- "extdata/auxiliaries.txt"
genomeFile <- "extdata/hg19sub.fa"

### Mapping reads to genome.
proj1 <- qAlign(sampleFile, genome = genomeFile, auxiliaryFile = auxFile)

### Checking the genome information.
library(GenomicFeatures)
annotFile <- "extdata/hg19sub_annotation.gtf"
chrLen <- scanFaIndex(genomeFile)
chrominfo <- data.frame(chrom = as.character(seqnames(chrLen)),
                        length = width(chrLen),
                        is_circular = rep(FALSE, length(chrLen)))

### We first create a TxDb object from a .gtf file with gene annotation.
txdb <- makeTxDbFromGFF(file = annotFile, format = "gtf",
                        chrominfo = chrominfo,
                        dataSource = "Ensembl",
                        organism = "Homo sapiens")
txdb

### With the promoters function, we can then create the GRanges object with regions to be quantified. 
### Finally, because most genes consist of multiple overlapping transcripts, we select the first transcript for each gene
promReg <- promoters(txdb, upstream = 1000, downstream = 500,
                     columns = c("gene_id","tx_id"))
gnId <- vapply(mcols(promReg)$gene_id,
               FUN = paste, FUN.VALUE = "",
               collapse = ",")
promRegSel <- promReg[match(unique(gnId), gnId)]
names(promRegSel) <- unique(gnId)
promRegSel

### Using promRegSel object as query, we can now count the alignment per sample in each of the promoter windows.
cnt <- qCount(proj1, promRegSel)
# ?qCount

### Quantification of gene and exon expression
geneLevels <- qCount(proj, txdb, reportLevel = "gene")
exonLevels <- qCount(proj, txdb, reportLevel = "exon")

### Calculation of RPKM expression values
geneRPKM <- t(t(geneLevels[,-1] / geneLevels[,1] * 1000)
              / colSums(geneLevels[,-1]) * 1e6)
geneRPKM

### End of Step-06.
### ****************************************************************************