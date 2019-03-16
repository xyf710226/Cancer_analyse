status_gene=zeros(41,1)
num_gene=zeros(41,1);
for i=1:41
    num=size(find(flag_gene(i,:)==0),2)
    num_gene(i,1)=num;
    if num>0.8*83
        status_gene(i,1)=1;
    end 
end
index_gene=find(status_gene==1);

status_reac=zeros(216,1)
num_reac=zeros(216,1);
for i=1:216
    num=size(find(flag_reac(i,:)==0),2)
    num_reac(i,1)=num;
    if num>0.8*83
        status_reac(i,1)=1;
    end 
end
index_reac=find(status_reac==1);