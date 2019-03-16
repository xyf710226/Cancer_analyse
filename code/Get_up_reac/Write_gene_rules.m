function[]=Write_gene_rules(Gene_up)
%   Write_gene
%   �������GENEд���ļ��У�txt��ʽ
%
%   Gene_up         17�ְ�֢�ϵ������cell����
%
%   �����, 2018-04-12
datafile={'blca','chol','coad','esca','gbm','hnsc','kich','kirc','kirp','lihc','luad','lusc','prad','read','stad','thca','ucec'};
upname='_all_RNA-seq_up.txt';
up_file=strcat(datafile,upname);
path='J:\My_reserach\Recon3D_experiment\data\TCGA_data_Entrez_new\';
load('J:\My_reserach\Recon3D_experiment\data\Recon3D_301\SubNetworkRecon');
for i=1:size(Gene_up,2)
    t=strcat(path,up_file{i});
    k=Gene_up{i};
    fid=fopen(t,'w');
    for j=1:size(k)
        fprintf(fid,'%s\n',Gene_up{i}{j});
    end
    fclose(fid);
end

path_rule='J:\My_reserach\Recon3D_experiment\data\Recon3D_301\data_new.txt';
fid=fopen(path_rule,'w');
fprintf(fid,'%s\n','grRule'); %��Ϊpython��Ҫһ����ͷ
for i=1:size(modelConsistent.grRules)
    fprintf(fid,'%s\n',strcat('[',modelConsistent.grRules{i},']'));
end
fclose(fid);