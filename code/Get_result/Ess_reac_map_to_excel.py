from pandas.io.parsers import read_csv
import pandas as pd
import scipy.io as scio
flag=0 #flag=1时输出反应表达式，flag=0时输出基因rules
data_path="J:/My_reserach/Recon3D_experiment/data/Result/mat_data/Ess_reac_tabulate_info.mat"
#Method 1

data = scio.loadmat(data_path)
data=data['ret_all']#取出字典里的label
Rxns_count=pd.DataFrame(data)
Rxns_count.pop(2)
Rxns_count[1]=Rxns_count[1].astype(int)
Rxns_count[0]=Rxns_count[0].astype(str)

Rxns_count[0]=[Rxns_count[0][i].replace('\'','').replace('[', '').replace(']', '') for i in range(len(Rxns_count[0]))]
Rxns_count[0]=[Rxns_count[0][i].split('.')[0] for i in range(len(Rxns_count[0]))]
if flag:
    Rxns_count.columns = ['Abbreviation','count']
else:
    Rxns_count.columns = ['m_reaction','count']



#rnxs_info.pop('m_gene')
if flag:
    excelFile = r'J:\My_reserach\Recon3D_experiment\data\Rxns_excel_info\Rxns_info.xlsx'
    rnxs_info = pd.DataFrame(pd.read_excel(excelFile))
else:
    excelFile = r'J:\My_reserach\Recon3D_experiment\data\Rxns_excel_info\Rxns_info_gene.xlsx'
    rnxs_info = pd.DataFrame(pd.read_excel(excelFile))
    rnxs_info=rnxs_info.drop_duplicates('m_reaction')

Rxns_count=Rxns_count[Rxns_count['count']>=10]
if flag:
    data=pd.merge(Rxns_count,rnxs_info,on='Abbreviation')
    datapath1 = r'J:\My_reserach\Recon3D_experiment\data\Result\8.1-Ess_reac_info.xls'
else:
    data=pd.merge(Rxns_count,rnxs_info,on='m_reaction')
    datapath1 = r'J:\My_reserach\Recon3D_experiment\data\Result\8.2-Ess_reac_info.xls'
#data_splite=data[(data['count']>=5) & (data['count3']>=5) | (data['count']==17) | (data['count3']==17)]
#data_splite=data[(data['count']==17) | (data['count3']==17)]


data.to_excel(datapath1, index=False)
print("over")