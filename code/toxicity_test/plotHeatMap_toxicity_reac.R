rm(list=ls())
library(pheatmap)
library(R.matlab)
data = readMat('flag_reac.mat');
expdata <- as.matrix(data$flag.reac)
pheatmap(expdata,main = "Heatmap of Exchange flux distribution",cellwidth = 5,cellheight= 5,cluster_row = FALSE,cluster_col=FALSE)
