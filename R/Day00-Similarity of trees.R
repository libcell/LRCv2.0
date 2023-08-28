
# ---------------------------------------------------------------------------- #
# Cophenetic correlation coefficient (CCC)
# ---------------------------------------------------------------------------- #

# Assuming you have two dendrograms stored in objects `dendro1` and `dendro2`
library(stats)

# Prepare two trees
dendro1 <- hclust(dist(iris[, -5]))
dendro2 <- hclust(dist(iris[, 1:3]))

# Calculate cophenetic distances for each dendrogram
dist1 <- cophenetic(as.hclust(dendro1))
dist2 <- cophenetic(as.hclust(dendro2))

# Calculate cophenetic correlation coefficient (CCC)
ccc <- cor(dist1, dist2)

# Print the CCC value
print(ccc)

par(mfrow = c(1, 2))
plot(dendro1)
plot(dendro1)
par(mfrow = c(1, 1))

# ---------------------------------------------------------------------------- #
# Symmetric Proportion (SP)
# ---------------------------------------------------------------------------- #

# Assuming you have two dendrograms stored in objects `dendro1` and `dendro2`
library(dendextend)

dendro1 <- as.dendrogram(dendro1)
dendro2 <- as.dendrogram(dendro2)
# Calculate the symmetric proportion (SP)
sp <- cor_common_nodes(dendro1, dendro2)

# Print the SP value
print(sp)


# ---------------------------------------------------------------------------- #
# Robinson-Foulds distance (SP)
# ---------------------------------------------------------------------------- #

# Assuming you have two dendrograms stored in objects `dendro1` and `dendro2`
library(TreeDist)

# Prepare two trees
dendro1 <- hclust(dist(iris[, -5]))
dendro2 <- hclust(dist(iris[, 1:3]))

dendro1 <- as.phylo(dendro1)
dendro2 <- as.phylo(dendro2)

library("TreeTools", quietly = TRUE)
#. balanced7 <- BalancedTree(7)
#. pectinate7 <- PectinateTree(7)

RobinsonFoulds(dendro1, dendro2)
RobinsonFoulds(dendro1, dendro2, normalize = TRUE)
VisualizeMatching(RobinsonFouldsMatching, balanced7, pectinate7)

InfoRobinsonFoulds(dendro1, dendro2)
VisualizeMatching(InfoRobinsonFoulds, dendro1, dendro2)


# ---------------------------------------------------------------------------- #
# Weighted UniFrac distance
# ---------------------------------------------------------------------------- #

# Assuming you have two dendrograms stored in objects `dendro1` and `dendro2`

# BiocManager::install("phyloseq") #!!! Not work!!!
library(phyloseq)

# Convert dendrograms to phyloseq objects
physeq1 <- as(phy_tree(as.hclust(dendro1)), "phyloseq")
physeq2 <- as(phy_tree(as.hclust(dendro2)), "phyloseq")

# Calculate the Weighted UniFrac distance
unifrac_dist <- UniFrac(physeq1, physeq2, weighted = TRUE)

# Print the Weighted UniFrac distance
print(unifrac_dist)

# ---------------------------------------------------------------------------- #
# Kendall's rank correlation coefficient
# ---------------------------------------------------------------------------- #

# Assuming you have two dendrograms stored in objects `dendro1` and `dendro2`
library(ape)

# Convert dendrograms to phylo objects !!! Not work!!!
tree1 <- as.phylo(as.hclust(dendro1))
tree2 <- as.phylo(as.hclust(dendro2))

# Calculate Kendall's rank correlation coefficient
kendall_corr <- corKendall(tree1, tree2)

# Print Kendall's rank correlation coefficient
print(kendall_corr)


# Assuming you have two clustering assignments stored in vectors `clustering1` and `clustering2`
library(fpc)

#  set.seed(20000)
options(digits=3)
face <- rFace(200,dMoNo=2,dNoEy=0,p=2)
dface <- dist(face)
complete3 <- cutree(hclust(dface),3)
cluster.stats(dface,complete3,
              alt.clustering=as.integer(attr(face,"grouping")))







