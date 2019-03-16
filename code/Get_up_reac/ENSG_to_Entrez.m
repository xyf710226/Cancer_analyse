datafile={'blca','chol','coad','esca','gbm','hnsc','kich','kirc','kirp','lihc','luad','lusc','prad','read','stad','thca','ucec'};
upname='_all_RNA-seq_up.txt';
up_file=strcat(datafile,upname);

for i=1:size(up_file,2)
    a=strvcat(Gene_up{i});
    [x,y]=size(a);
    fid=fopen(up_file{i},'w+');
    for i=1:x
        fprintf(fid,'%s\n',a(i,:));
    end
    fclose(fid);
end