from pandas.io.parsers import read_csv
import pandas as pd
import scipy.io as scio
excelFile = r'J:\My_reserach\Recon3D_experiment\data\zlx_Result\data\Ess_gene_Recon3D_info.xls'
gene_Recon3D = pd.DataFrame(pd.read_excel(excelFile))

excelFile = r'J:\My_reserach\Recon3D_experiment\data\zlx_Result\data\Ess_gene_HMR_info.xls'
gene_HMR = pd.DataFrame(pd.read_excel(excelFile))

excelFile = r'J:\My_reserach\Recon3D_experiment\data\zlx_Result\data\Ess_gene_Recon2_info.csv'
gene_Recon2=pd.DataFrame(pd.read_csv(excelFile))
gene_Recon2.pop(gene_Recon2.keys()[0])
gene_Recon2['gene']=gene_Recon2['gene'].astype(str)
gene_Recon2['gene']=[gene_Recon2['gene'][i].split('.')[0] for i in range(len(gene_Recon2['gene']))]
gene_Recon2['gene']=gene_Recon2['gene'].astype(int)

see=pd.merge(gene_HMR,gene_Recon2,left_on='GENE ID 2',right_on='gene')

data=pd.merge(gene_Recon3D,gene_HMR,left_on='EntrezGene ID',right_on='GENE ID 2')
data=pd.merge(data,gene_Recon2,left_on='EntrezGene ID',right_on='gene')
datapath1 =r'J:\My_reserach\Recon3D_experiment\data\Result\10-HMR_same_Recon3D_ess_gene.xls'
data.to_excel(datapath1, index=False)
print('over')