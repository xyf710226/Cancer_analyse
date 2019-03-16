function ret=Get_ret(data)
if size(data)==1
    data=data';
end
    
ret = data{1};
for k = 2:17
    ret = intersect(ret, data{k});
end