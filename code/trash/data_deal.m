%��ENSG������ϵ�����ĳ�Entrez�Ļ���
[~,loc]=ismember(upgene,ENSG)
r=find(loc>0)
upgene_Entrez=Entrez(loc(r));
[~,loc_gene]=ismember(upgene_Entrez,Recon3DModel_re_gene.genes(:,1))
r=find(loc_gene>0);
upgene_id=loc_gene(r);
upgene_name=Recon3DModel_re_gene.genes(upgene_id,1);
%��ģ���еĻ�������֣�������˵26.1-��26 1��ǰ���ǻ����ź�����ǰ汾�ţ�
%{
genedelete=[];
for i=1:size(Recon3DModel.genes)
    str=Recon3DModel.genes(i);
    str=regexp( str, '\w+',  'match' );
    str=str{1,1};
    if i==2125
        str=[str,'0']
    end
    genedelete=[genedelete;str];
end
a=char(genedelete)
b=str2num(a)
b=reshape(b,size(Recon3DModel.genes,1),2);
Recon3DModel.genes=b;
%}
%{
for i =1:2
    for j=1:size(genedelete,1)
        genedelete_num(j,i)=genedelete(j,i)
    end
end
%}