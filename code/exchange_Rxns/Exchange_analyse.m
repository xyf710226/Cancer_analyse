%�ҵ����Է�Ӧ��λ�ã�ֱ�ӽ�������������
load('J:\My_reserach\Recon3D_experiment\data\Recon3D_301\SubNetworkRecon.mat');
load('J:\My_reserach\Recon3D_experiment\data\Result\mat_data\Flux_Matrix.mat');
for i=1:size(ret)
    ret{i}=strrep(ret{i},'(','[');
    ret{i}=strrep(ret{i},')',']');
end
[tf ret_index]=ismember(ret,modelConsistent.rxns);
Exchange_Flux=Flux_Matrix(ret_index,:);

dlmwrite('Exchange_ret_flux.txt',Exchange_Flux,' ');
clear j flag k

%�õ����Խ�����Ӧ�����������
 S_index=modelConsistent.S(:,ret_index)
[x1,y1]=find(abs(S_index)~=0);
 retName=modelConsistent.metNames(x1);
retMet=modelConsistent.mets(x1);
 
 clear i