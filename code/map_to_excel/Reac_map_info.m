function [result]=Reac_map_info(reac_name,filename)
%   Reac_map_info
%   ��mat��ʽ�ķ�Ӧ��ת����excel��ʽ����ϸ��Ϣ
%
%   reac_name           ��Ҫ����ת���ķ�Ӧ���ƣ�HMRxxxx)
%   ess_gene_name       resultת�������ϸ��Ϣ
%   filename            д����ļ���
%   �����, 2018-04-12
%
[A,B,C]=xlsread('J:\My_reserach\Recon3D_experiment\data\Rxns_excel_info\Rxns_info.xlsx',1);
[Lia,Loc] = ismember(reac_name,B(:,1));
%[Lia,Loc] = ismember(ret,B(:,1));
Loc(find(Loc==0))=[];
result=B(Loc,[1,2,3]);
%result=result(:,[2,4,5,6,10,11,12,13,14,15,16,17,18]);
title=B(3,[1,2,3]);
result=[title;result];
filename=strcat('J:\My_reserach\Recon3D_experiment\data\Result\',filename);
xlswrite(filename,result);