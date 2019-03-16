function [upgene_name]=Get_txtfile_info(file_name)
%从'J:\My_reserach\Recon3D_experiment\data\TCGA_data'文件txt中获取基因名以及映射反应
addpath('J:\My_reserach\Recon3D_experiment\data\TCGA_data');
addpath('J:\My_reserach\Recon3D_experiment\data\Recon3D_301');
[Entrez,ENSG]=Get_genemap();
load('SubNetworkRecon_splite_gene.mat');
load('SubNetworkRecon');
fid = fopen(file_name);
tline = fgetl(fid);
i=0;
upgene={};
reac_index={};
reac_flag={};
Gene_index={};
while ischar(tline)
    str=tline;
    str=regexp( str, '\w+',  'match' );
    str=str(1);
    upgene=[upgene;str];
    tline = fgetl(fid);
end
[~,loc]=ismember(upgene,ENSG)
r=find(loc>0)
upgene_Entrez=Entrez(loc(r));
%这种没有包含重复的
%{
[~,loc_gene]=ismember(upgene_Entrez,modelConsistent_splite_gene.genes);
r=find(loc_gene>0);
upgene_id=loc_gene(r);
%}
[~,loc_gene]=ismember(modelConsistent_splite_gene.genes,upgene_Entrez);
r=find(loc_gene>0);
upgene_id=r;
upgene_name=modelConsistent.genes(upgene_id);
