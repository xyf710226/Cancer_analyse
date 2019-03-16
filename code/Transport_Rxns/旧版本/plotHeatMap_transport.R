rm(list=ls())
library(pheatmap)
data <- read.delim("Transport_ret_flux.txt",sep=" ",header = FALSE)
expdata <- as.matrix(data)

colnames(expdata)<- c("blca","chol","coad","esca","gbm","hnsc","kich","kirc","kirp","lihc","luad","lusc","prad","read","stad","thca","ucec");

rownames(expdata)<-c('acgam[l->c]'
                     ,'adp->atp[m]' #2
                     ,'q10[m]/focytC[m]'
                     ,'datp[c->n]'
                     ,'dctp[c->n]'
                     ,'dgtp[c->n]'
                     ,'dttp[c->n]'
                     ,'f1a[e->l]'
                     ,'gal[l->c]'
                     ,'h2o[c->g]'   #10
                     ,'h2o[c->l]'
                     ,'h2o[c->m]'
                     ,'h[g->c]'
                     ,'o2[c->m]'
                     ,'pglyc_hs[e->c]'
                     ,'pi[g->c]'
                     ,'ps_hs[e->c]'
                     ,'Ser_Thr[g->l]'
                     ,'udpacgal[c->l]'
                     ,'udpgal[c->g]'   #20
                     ,'udp[c->l]'
                     ,'udpacgal[c->g]/ump[g->c]'
                     ,'uacgam[c->g]/ump[g->c]'
                     ,'utp[c->e]'
                     ,'atp[c->e]')

 
pheatmap(expdata,main = "Heatmap of Transport flux distribution",cellwidth = 20,cellheight= 10,cluster_row = FALSE)
