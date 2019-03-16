%function[Gene_up, Gene_down]=Get_all_txtfile_info()
function[Gene_up]=Get_all_txtfile_info()
%   Get_all_info
%   从'J:\My_reserach\Recon3D_experiment\data\TCGA_data'目录文件夹中读取所有癌症的上调反应，下调反应
%
%   Gene_up         17种癌症上调基因的cell集合
%   Gene_down       17种癌症下调基因的cell集合
%
%   熊宇峰, 2018-04-12
datafile={'blca','chol','coad','esca','gbm','hnsc','kich','kirc','kirp','lihc','luad','lusc','prad','read','stad','thca','ucec'};
upname='_all_RNA-seq_up.txt';
downname='_all_RNA-seq_down.txt';
mname='_model';
up_file=strcat(datafile,upname);
down_file=strcat(datafile,downname);
for i=1:size(datafile,2)
    [Gene_up{i}]=Get_txtfile_info(up_file{i});
    %[Gene_down{i}]=Get_txtfile_info(down_file{i});
end