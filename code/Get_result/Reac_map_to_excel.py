from pandas.io.parsers import read_csv
import pandas as pd
import scipy.io as scio

data_path="J:/My_reserach/Recon3D_experiment/data/Result/mat_data/Rxns_tabulate_info.mat"
#Method 1

data = scio.loadmat(data_path)
data=data['Rxns_all']#取出字典里的label
Rxns_count=pd.DataFrame(data)
Rxns_count.pop(2)
Rxns_count[1]=Rxns_count[1].astype(int)
Rxns_count[0]=Rxns_count[0].astype(str)

Rxns_count[0]=[Rxns_count[0][i].replace('\'','').replace('[', '').replace(']', '') for i in range(len(Rxns_count[0]))]
Rxns_count[0]=[Rxns_count[0][i].split('.')[0] for i in range(len(Rxns_count[0]))]
Rxns_count.columns = ['Abbreviation','count']

excelFile = r'J:\My_reserach\Recon3D_experiment\data\Rxns_excel_info\Rxns_info.xlsx'
rnxs_info = pd.DataFrame(pd.read_excel(excelFile))


Rxns_count=Rxns_count[Rxns_count['count']>=10]

data=pd.merge(Rxns_count,rnxs_info,on='Abbreviation')
#data_splite=data[(data['count']>=5) & (data['count3']>=5) | (data['count']==17) | (data['count3']==17)]
#data_splite=data[(data['count']==17) | (data['count3']==17)]

datapath1 =r'J:\My_reserach\Recon3D_experiment\data\Result\2-up_rxns_info.xls'
data.to_excel(datapath1, index=False)
print("over")