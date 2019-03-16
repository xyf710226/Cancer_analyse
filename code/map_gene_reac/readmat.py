from pandas import Series,DataFrame
import pandas as pd
import numpy as np
import h5py
import mat4py

data = mat4py.loadmat('J:\My_reserach\Recon3D_experiment\data\Recon3D_301/grRules.mat')

dfdata = pd.DataFrame(data)
datapath1 ='J:\My_reserach\Recon3D_experiment\data\Recon3D_301/data.txt'
dfdata.to_csv(datapath1, index=False)

