%all_Model={blca_Model,chol_Model,coad_Model,esca_Model,gbm_Model,hnsc_Model,kich_Model,kirc_Model,kirp_Model,lihc_Model,luad_Model,lusc_Model,prad_Model,read_Model,stad_Model,thca_Model,ucec_Model};
%all_Model={blca_init_model,chol_init_model,coad_init_model,esca_init_model,gbm_init_model,hnsc_init_model,kich_init_model,kirc_init_model,kirp_init_model,lihc_init_model,luad_init_model,lusc_init_model,prad_init_model,read_init_model,stad_init_model,thca_init_model,ucec_init_model}
all_Model_recon2={blca_work_model,chol_work_model,coad_work_model,esca_work_model,gbm_work_model,hnsc_work_model,kich_work_model,kirc_work_model,kirp_work_model,lihc_work_model,luad_work_model,lusc_work_model,prad_work_model,read_work_model,stad_work_model,thca_work_model,ucec_work_model}
counts_recon2=zeros(size(all_Model_recon2,2),3);
for i=1:size(all_Model_recon2,2)
    x=all_Model_recon2{i};
    counts_recon2(i,1)=size(x.rxns,1);
    counts_recon2(i,2)=size(x.mets,1);
    counts_recon2(i,3)=size(x.genes,1);
    %I=haveFlux(x);
    %num=size(find(I==1),1);
    %counts(i,4)=num;
end

clear i,x,all_Model_recon2


    