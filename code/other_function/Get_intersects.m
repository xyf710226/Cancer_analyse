function [intersects]=Get_intersects(cells,r)
%求一个cell数组的交集，r代表是行还是列数组
intersects=cells{1};
for i=1:size(cells,r)
    intersects=intersect(intersects,cells{i});
end