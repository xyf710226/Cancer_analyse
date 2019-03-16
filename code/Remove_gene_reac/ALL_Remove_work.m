%对所有癌症模型进行基因及反应的敲除，并保存起来
%%{
%Work_cancer_Model=[blca_work_model];chol_work_model;coad_work_model;esca_work_model;gbm_work_model;hnsc_work_model;kich_work_model;kirc_work_model;kirp_work_model;lihc_work_model;luad_work_model;lusc_work_model;prad_work_model;read_work_model;stad_work_model;thca_work_model;ucec_work_model]
%读取差异网络
%load('J:\My_reserach\Recon3D_experiment\data\CancerModel\Cancer_Model')
load('J:\My_reserach\Recon3D_experiment\data\CancerModel\Cancer_work_Model')

%！注意这里要不要转置，工作网络需要转置，差异网络不需要
Cancer_Model=Cancer_work_Model;
%Cancer_Model=Cancer_Model';
for i=1:size(Cancer_Model,1)
    Model_gene=Cancer_Model{i};
    [ess_gene_name{i},result]=Remove_Gene(Model_gene);
    %Model_reac=Cancer_Model{i};
    %[ess_reac_name{i},reuslt]=Remove_Reac(Model_reac);
    %save(m_file{i},'Model');
    %save(g_file{i},'ess_gene_name');
    %save(a_file{i},'ess_reac_name');
    %clear Model ess_gene_name ess_reac_name;
end
ess_gene_name=ess_gene_name';
%ess_reac_name=ess_reac_name';
%}

%求必要基因的交集
%{
c=ess_gene_name{1};
all_gene=c;
for i=2:size(ess_gene_name)
    c=intersect(ess_gene_name{i},c);
    all_gene=[all_gene;ess_gene_name{i}];
end
t=tabulate(all_gene);
c_16up=t(cell2mat(t(:,2))>14);
clear i Model_gene Model_reac 
%}
%求必要反应的交集
%{
r=ess_reac_name{1};
all_reac=r;
for i=2:size(ess_reac_name)
    r=intersect(ess_reac_name{i},r);
    all_reac=[all_reac;ess_reac_name{i}];
end
t=tabulate(all_reac);
r_16up=t(cell2mat(t(:,2))>15);
clear i Model_gene Model_reac 
%}