function [result]=Gene_map_info(Gene_name,filename)
%   Reac_map_info
%   ��mat��ʽ�ķ�Ӧ��ת����excel��ʽ����ϸ��Ϣ
%
%   reac_name           ��Ҫ����ת���ķ�Ӧ���ƣ�HMRxxxx)
%   ess_gene_name       resultת�������ϸ��Ϣ
%   filename            д����ļ���
%   �����, 2018-04-12
%
[A,B,C]=xlsread('HMRdatabase2_00.xlsx',5);
[Lia,Loc] = ismember(Gene_name,C(:,2));
result=C(Loc,:);
result=result(:,[2,3,4,5,6,7]);
title=C(1,[2,3,4,5,6,7]);
result=[title;result];
xlswrite(filename,result);