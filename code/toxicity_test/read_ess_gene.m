[numericData, textData, rawData] = xlsread('Ess_gene_info.xls');
all_ess_gene=textData(:,3);
all_ess_gene(1)=[];