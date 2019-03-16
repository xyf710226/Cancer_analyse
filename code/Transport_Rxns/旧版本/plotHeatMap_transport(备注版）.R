rm(list=ls())
library(pheatmap)
data <- read.delim("Transport_ret_flux.txt",sep=" ",header = FALSE)
expdata <- as.matrix(data)

colnames(expdata)<- c("blca","chol","coad","esca","gbm","hnsc","kich","kirc","kirp","lihc","luad","lusc","prad","read","stad","thca","ucec");

rownames(expdata)<-c('acgam[c](N-Acetyl-D-Glucosamine)'
                     ,'h2o[m]/atp[m]' #2
                     ,'q10[m](Ubiquinone-10)/focytC[m](Ferrocytochrome C)'
                     ,'datp[n](Deoxyadenosine Triphosphate)'
                     ,'dctp[n](Deoxycytidine-5\'-Triphosphate)'
                     ,'dgtp[n](Deoxyguanosine-5\'-Triphosphate)'
                     ,'dttp[n](Deoxythymidine-5\'-Triphosphate)'
                     ,'f1a[l](F1Alpha)'
                     ,'gal[c](D-Galactose)'
                     ,'h2o[g](Water)'   #10
                     ,'h2o[l](Water)'
                     ,'h2o[m](Water)'
                     ,'h[c](Proton)'
                     ,'o2[m](Oxygen)'
                     ,'pglyc_hs[c](Phosphatidylglycerol)'
                     ,'pi[c](Orthophosphate)'
                     ,'ps_hs[c](Phosphatidylserine)'
                     ,'Ser_Thr[l](Protein-Linked Serine Or Threonine Residue (O-Glycosylation Site))'
                     ,'udpacgal[l](Uridine-5\'-Diphosphate-N-Acetyl-D-Galactosamine)'
                     ,'udpgal[g](Uridine-5\'-Diphosphate-D-Galactose)/ump[c](Uridine-5\'-Monophosphate)'   #20
                     ,'udp[l](Uridine Diphosphate)'
                     ,'udpacgal[g](Uridine-5\'-Diphosphate-N-Acetyl-D-Galactosamine)/ump[c](Uridine-5\'-Monophosphate)'
                     ,'uacgam[g](Uridine-5\'-Diphosphate-N-Acetyl-Alpha-D-Glucosamine)/ump[c](Uridine-5\'-Monophosphate)'
                     ,'utp[e](Uridine-5\'-TrIphosphate)'
                     ,'atp[e](Adenosine Triphosphate)');

 
pheatmap(expdata,main = "Heatmap of Transport flux distribution",cellwidth = 20,cellheight= 10,cluster_row = FALSE)
