import pandas as pd
import scipy.io as scio
data_path="J:/My_reserach/Recon3D_experiment/data/Result/mat_data/Ess_gene_tabulate_info.mat"
#Method 1

data = scio.loadmat(data_path)
data=data['ret_all']#取出字典里的label
gene_count=pd.DataFrame(data)
gene_count.pop(2)
gene_count[1]=gene_count[1].astype(int)
gene_count[0]=gene_count[0].astype(str)

gene_count[0]=[gene_count[0][i].replace('\'','').replace('[', '').replace(']', '') for i in range(len(gene_count[0]))]
gene_count[0]=[gene_count[0][i].split('.')[0] for i in range(len(gene_count[0]))]
gene_count[0]=gene_count[0].astype(int)
gene_count.columns = ['EntrezGene ID','count']

excelFile = 'J:/My_reserach/Recon3D_experiment/data/Gene_excel_info/Gene_info.xlsx'
gene_info = pd.DataFrame(pd.read_excel(excelFile))


#gene_count=gene_count[gene_count['count']>=10]

data=pd.merge(gene_count,gene_info,on='EntrezGene ID')
#data_splite=data[(data['count']>=5) & (data['count3']>=5) | (data['count']==17) | (data['count3']==17)]
#data_splite=data[(data['count']==17) | (data['count3']==17)]

#datapath1 =r'J:\My_reserach\Recon3D_experiment\data\Result\7-Ess_gene_info.xls'
datapath1 =r'J:\My_reserach\Recon3D_experiment\data\zlx_Result\data\Ess_gene_Recon3D_info.xls'
data.to_excel(datapath1, index=False)
print("over")