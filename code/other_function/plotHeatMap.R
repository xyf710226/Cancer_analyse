rm(list=ls())
library(pheatmap)
data <- read.delim("cancer_flux.txt",sep=" ",header = FALSE)
expdata <- as.matrix(data)

colnames(expdata)<- c("blca","chol","coad","esca","gbm","hnsc","kich","kirc","kirp","lihc","luad","lusc","prad","read","stad","thca","ucec");

pheatmap(expdata,cluster_row = FALSE,main = "Heatmap of Metabolic flux distribution")

