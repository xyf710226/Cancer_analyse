rm(list=ls())
library(pheatmap)
library("R.matlab")
data = readMat('flag_gene.mat');
#expdata <- as.matrix(data$flag.reac)
expdata<-data[[1]]
pheatmap(expdata,main = "Heatmap of toxicty flux distribution",cellwidth = 5,cellheight= 5,cluster_row = FALSE,cluster_col=FALSE)

#data <- read.delim("toxicity_flag.txt",sep=" ",header = FALSE)
#expdata <- as.matrix(data)
#pheatmap(expdata,main = "Heatmap of Exchange flux distribution",cellwidth = 10,cellheight= 10,cluster_row = FALSE,cluster_col=FALSE)
