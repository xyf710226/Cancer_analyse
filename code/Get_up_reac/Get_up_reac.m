function [Rxns_up]=Get_up_reac()
%读取所有上调代谢反应
addpath('J:\My_reserach\Recon3D_experiment\data\reaction');
load('J:\My_reserach\Recon3D_experiment\data\Recon3D_301\SubNetworkRecon.mat');
datafile={'blca','chol','coad','esca','gbm','hnsc','kich','kirc','kirp','lihc','luad','lusc','prad','read','stad','thca','ucec'};
upname='_core_reaction_new.csv';
up_file=strcat(datafile,upname);
Rxns_up=cell(17,1)
for i=1:17
    Rxns_up{i}=csvread(up_file{i},1,1);
    id=find(ismember(modelConsistent.rxns,'biomass_reaction'))
    Rxns_up{i}=sort([Rxns_up{i};id]);
    
end
