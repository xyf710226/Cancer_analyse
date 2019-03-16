from pandas.io.parsers import read_csv
import pandas as pd
#将recon2 和 recon3 的基因敲除结果合起来
f_rules = 'J:/My_reserach/Recon3D_experiment/data/recon2_result/gene_count.csv'
recon2 = read_csv(f_rules)
recon2['gene']=recon2['gene'].astype(str)
recon2.pop(recon2.keys()[0])

#import mat4py
#recon3 = mat4py.loadmat('J:/My_reserach/Recon3D_experiment/data/recon2_result/ess_gene_count.mat')
#recon3=recon3['count']
#data = pd.DataFrame.from_dict(recon3)

import scipy.io as scio

data_path="J:/My_reserach/Recon3D_experiment/data/recon2_result/ess_gene_count.mat"

#Method 1

data = scio.loadmat(data_path)
data=data['count']#取出字典里的label
recon3=pd.DataFrame(data)
recon3[1]=recon3[1].astype(int)
recon3[0]=recon3[0].astype(str)
recon3[0]=[recon3[0][i].replace('\'','').replace('[', '').replace(']', '') for i in range(len(recon3[0]))]
recon3.columns = ['gene','count3']
recon2_17=recon2[recon2['count']==17]
recon3_17=recon3[recon3['count3']==17]

data=pd.merge(recon2,recon3,on='gene')
#data_splite=data[(data['count']>=5) & (data['count3']>=5) | (data['count']==17) | (data['count3']==17)]
data_splite=data[(data['count']==17) | (data['count3']==17)]

datapath1 ='J:/My_reserach/Recon3D_experiment/data/recon2_result//gene23count.csv'
data_splite.to_csv(datapath1, index=False)
print("over")


