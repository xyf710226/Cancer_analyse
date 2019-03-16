function [result]=Gene_map_info(Gene_name,filename)
%   Reac_map_info
%   将mat格式的反应名转换成excel格式的详细信息
%
%   reac_name           需要进行转换的反应名称（HMRxxxx)
%   ess_gene_name       result转换后的详细信息
%   filename            写入的文件名
%   熊宇峰, 2018-04-12
%
[A,B,C]=xlsread('HMRdatabase2_00.xlsx',5);
[Lia,Loc] = ismember(Gene_name,C(:,2));
result=C(Loc,:);
result=result(:,[2,3,4,5,6,7]);
title=C(1,[2,3,4,5,6,7]);
result=[title;result];
xlswrite(filename,result);