rm(list=ls())
library(pheatmap)
data <- read.delim("Transport_ret_flux.txt",sep=" ",header = FALSE)
expdata <- as.matrix(data)

colnames(expdata)<- c("blca","chol","coad","esca","gbm","hnsc","kich","kirc","kirp","lihc","luad","lusc","prad","read","stad","thca","ucec");

rownames(expdata)<-c('acgam[l]  -> acgam[c]' 
                     ,'gluside_hs[c]  <=> gluside_hs[r]'
                     ,'cmp[g] + cmpacna[c]  <=> cmp[c] + cmpacna[g]' 
                     ,'co2[c]  <=> co2[r]' 
                     ,'datp[c]  <=> datp[n]' 
                     ,'dctp[c]  <=> dctp[n]' 
                     ,'dgtp[c]  <=> dgtp[n]' 
                     ,'dttp[c]  <=> dttp[n]' 
                     ,'gal[l]  -> gal[c]' 
                     ,'h2o[c]  <=> h2o[g]' 
                     ,'h2o[c]  <=> h2o[l]' 
                     ,'h2o[c]  <=> h2o[m]' 
                     ,'h[g]  <=> h[c]' 
                     ,'o2[c]  <=> o2[r]' 
                     ,'paps[c]  <=> paps[g]' 
                     ,'pap[g]  -> pap[c]' 
                     ,'pe_hs[e]  <=> pe_hs[c]' 
                     ,'pglyc_hs[e]  <=> pglyc_hs[c]' 
                     ,'pi[g]  -> pi[c]' 
                     ,'ps_hs[e]  <=> ps_hs[c]' 
                     ,'Ser_Thr[g]  <=> Ser_Thr[l]' 
                     ,'udpacgal[c]  <=> udpacgal[l]' 
                     ,'udpgal[c] + ump[g]  <=> udpgal[g] + ump[c]' 
                     ,'udp[c]  <=> udp[l]' 
                     ,'ump[g] + udpacgal[c]  <=> udpacgal[g] + ump[c]' 
                     ,'uacgam[c] + ump[g]  <=> uacgam[g] + ump[c]' 
                     ,'utp[c]  <=> utp[e]' 
                     ,'HC00250[c]  <=> HC00250[e]' 
                     ,'atp[c]  <=> atp[e]' 
                     ,'f1a[e]  <=> f1a[l]' 
                     ,'o2[e]  <=> o2[c]' 
                     ,'gluside_hs[c]  <=> gluside_hs[e]' 
                     ,'galgluside_hs[r]  <=> galgluside_hs[c]'
                     ,'adp[m] + 4.0 h[i] + pi[m] -> atp[m] + 3.0 h[m] + h2o[m] '
                     ,'2.0 ficytC[m] + 2.0 h[m] + q10h2[m] -> 2.0 focytC[m] + 4.0 h[i] + q10[m] '
                     ,'udpglcur[e]  <=> udpglcur[c]' 
);

 
pheatmap(expdata,main = "Heatmap of Transport flux distribution",cellwidth = 20,cellheight= 10,cluster_row = FALSE)
