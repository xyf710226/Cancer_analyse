function [count]=Get_count(cells,r)
%��һ��cell����Ľ�����r�������л���������
all=cells{1};
for i=2:size(cells,r)
    all=[all;cells{i}];
end
count=tabulate(all);

