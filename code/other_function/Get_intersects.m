function [intersects]=Get_intersects(cells,r)
%��һ��cell����Ľ�����r�������л���������
intersects=cells{1};
for i=1:size(cells,r)
    intersects=intersect(intersects,cells{i});
end