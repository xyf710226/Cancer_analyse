function [result]=Reac_map_info(reac_name,filename)
%   Reac_map_info
%   将mat格式的反应名转换成excel格式的详细信息
%
%   reac_name           需要进行转换的反应名称（HMRxxxx)
%   ess_gene_name       result转换后的详细信息
%   filename            写入的文件名
%   熊宇峰, 2018-04-12
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