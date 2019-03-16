rm(list=ls())
library(pheatmap)
data <- read.delim("Exchange_ret_flux.txt",sep=" ",header = FALSE)
expdata <- as.matrix(data)

colnames(expdata)<- c("blca","chol","coad","esca","gbm","hnsc","kich","kirc","kirp","lihc","luad","lusc","prad","read","stad","thca","ucec");

rownames(expdata)<-c('atp[e] <=>' 
                       ,'inost[e]' 
                       ,'pe_hs[e]' 
                       ,'pglyc_hs[e]'
                       ,'ps_hs[e]'
                       ,'utp[e]'
                       ,'HC00250[e]'
                       ,'f1a[e]' 
                       ,'ile_L[e]'
                       ,'lys_L[e]' 
                       ,'met_L[e]' 
                       ,'o2[e]' 
                       ,'so4[e]' 
                       ,'uri[e]' 
                       ,'val_L[e]' 
                       ,'thr_L[e]' 
                       ,'gln_L[e]' 
                       ,'phe_L[e]' 
                       ,'arg_L[e]' 
                       ,'ac[e]' 
                       ,'trp_L[e]' 
                       ,'udpglcur[e]' 
)

 
pheatmap(expdata,main = "Heatmap of Transport flux distribution",cellwidth = 20,cellheight= 10,cluster_row = FALSE)
