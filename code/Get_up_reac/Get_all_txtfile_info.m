%function[Gene_up, Gene_down]=Get_all_txtfile_info()
function[Gene_up]=Get_all_txtfile_info()
%   Get_all_info
%   ��'J:\My_reserach\Recon3D_experiment\data\TCGA_data'Ŀ¼�ļ����ж�ȡ���а�֢���ϵ���Ӧ���µ���Ӧ
%
%   Gene_up         17�ְ�֢�ϵ������cell����
%   Gene_down       17�ְ�֢�µ������cell����
%
%   �����, 2018-04-12
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