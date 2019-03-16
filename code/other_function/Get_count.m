function [count]=Get_count(cells,r)
%求一个cell数组的交集，r代表是行还是列数组
all=cells{1};
for i=2:size(cells,r)
    all=[all;cells{i}];
end
count=tabulate(all);

