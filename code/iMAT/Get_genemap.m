%��ȡENSG��Entrez��ת��excel��
function [Entrez,ENSG]=Get_genemap()
addpath('J:\My_reserach\Recon3D_experiment\data\Recon3D_301');
%load('SubNetworkRecon.mat');
[Entrez,ENSG]=xlsread('map_ENSG_to_Entrez.xlsx');
