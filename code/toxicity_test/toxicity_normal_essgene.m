%记录每个正常细胞网络敲除癌症必要基因之后的状态，需要事先读入必要基因
addpath('F:\重现工作\师姐数据\Healthy');
addpath('F:\实验数据');
gene_size=size(all_ess_gene,1)
task=parseTaskList('TASKS.csv');
%load('ess_gene.mat');
%load('ess_reac.mat');
%datafile={'vulva-anal_skin_-_epidermal_cells_2','vagina_-_squamous_epithelial_cells_2','uterus,_pre-menopause_-_glandular_cells_2','uterus,_pre-menopause_-_cells_in_endometrial_stroma_2','uterus,_post-menopause_-_glandular_cells_2','uterus,_post-menopause_-_cells_in_endometrial_stroma_2','urinary_bladder_-_urothelial_cells_2','tonsil_-_squamous_epithelial_cells_2','tonsil_-_non-germinal_center_cells_2','tonsil_-_germinal_center_cells_2','thyroid_gland_-_glandular_cells_2','testis_-_cells_in_seminiferus_ducts_2','stomach,_upper_-_glandular_cells_2','stomach,_lower_-_glandular_cells_2','spleen_-_cells_in_white_pulp_2','spleen_-_cells_in_red_pulp_2','soft_tissue_2_-_peripheral_nerve_2','soft_tissue_2_-_fibroblasts_2','soft_tissue_2_-_chondrocytes_2','soft_tissue_2_-_adipocytes_2','soft_tissue_1_-_peripheral_nerve_2','soft_tissue_1_-_fibroblasts_2','soft_tissue_1_-_chondrocytes_2','soft_tissue_1_-_adipocytes_2','smooth_muscle_-_smooth_muscle_cells_2','small_intestine_-_glandular_cells_2','skin_-_melanocytes_2','skin_-_keratinocytes_2','skin_-_fibroblasts_2','skeletal_muscle_-_myocytes_2','seminal_vesicle_-_glandular_cells_2','salivary_gland_-_glandular_cells_2','rectum_-_glandular_cells_2','prostate_-_glandular_cells_2','placenta_-_trophoblastic_cells_2','placenta_-_decidual_cells_2','parathyroid_gland_-_glandular_cells_2','pancreas_-_exocrine_glandular_cells_2','ovary_-_ovarian_stroma_cells_2','ovary_-_follicle_cells_2','oral_mucosa_-_squamous_epithelial_cells_2','nasopharynx_-_respiratory_epithelial_cells_2','lymph_node_-_non-germinal_center_cells_2','lymph_node_-_germinal_center_cells_2','lung_-_pneumocytes_2','lung_-_macrophages_2','liver_-_hepatocytes_2','liver_-_bile_duct_cells_2','lateral_ventricle_-_neuronal_cells_2','lateral_ventricle_-_glial_cells_2','kidney_-_cells_in_tubules_2','kidney_-_cells_in_glomeruli_2','iTestisLeydig1766','iSkinEpidermal1432','iPancreasIslet1650','iCerebellumPurkinje1565','hippocampus_-_neuronal_cells_2','hippocampus_-_glial_cells_2','heart_muscle_-_myocytes_2','gallbladder_-_glandular_cells_2','fallopian_tube_-_glandular_cells_2','esophagus_-_squamous_epithelial_cells_2','epididymis_-_glandular_cells_2','duodenum_-_glandular_cells_2','colon_-_peripheral_nerve-ganglion_2','colon_-_glandular_cells_2','colon_-_endothelial_cells_2','cervix,_uterine_-_squamous_epithelial_cells_2','cervix,_uterine_-_glandular_cells_2','cerebral_cortex_-_neuropil_2','cerebral_cortex_-_neuronal_cells_2','cerebral_cortex_-_glial_cells_2','cerebral_cortex_-_endothelial_cells_2','cerebellum_-_cells_in_molecular_layer_2','cerebellum_-_cells_in_granular_layer_2','bronchus_-_respiratory_epithelial_cells_2','breast_-_myoepithelial_cells_2','breast_-_glandular_cells_2','breast_-_adipocytes_2','bone_marrow_-_hematopoietic_cells_2','appendix_-_lymphoid_tissue_2','appendix_-_glandular_cells_2','adrenal_gland_-_glandular_cells_2'};
datafile={'vagina - squamous epithelial cells', 'appendix - glandular cells', 'appendix - lymphoid tissue', 'bone marrow - hematopoietic cells', 'breast - adipocytes', 'breast - glandular cells','breast - myoepithelial cells', 'bronchus - respiratory epithelial cells', 'cerebellum - cells in granular layer', 'cerebellum - cells in molecular layer', 'cerebellum - Purkinje cells', 'cerebral cortex - endothelial cells','cerebral cortex - glial cells', 'cerebral cortex - neuronal cells', 'cerebral cortex - neuropil', 'cervix, uterine - glandular cells', 'cervix, uterine - squamous epithelial cells', 'colon - endothelial cells','colon - glandular cells', 'colon - peripheral nerve-ganglion', 'duodenum - glandular cells', 'epididymis - glandular cells', 'esophagus - squamous epithelial cells', 'fallopian tube - glandular cells','gallbladder - glandular cells', 'heart muscle - myocytes', 'hippocampus - glial cells', 'hippocampus - neuronal cells', 'kidney - cells in glomeruli', 'kidney - cells in tubules','lateral ventricle - glial cells', 'lateral ventricle - neuronal cells', 'liver - bile duct cells', 'liver - hepatocytes', 'lung - macrophages', 'lung - pneumocytes','lymph node - germinal center cells', 'lymph node - non-germinal center cells', 'nasopharynx - respiratory epithelial cells', 'oral mucosa - squamous epithelial cells', 'ovary - follicle cells', 'ovary - ovarian stroma cells','pancreas - exocrine glandular cells', 'pancreas - islets of Langerhans', 'parathyroid gland - glandular cells', 'placenta - decidual cells', 'placenta - trophoblastic cells', 'prostate - glandular cells','rectum - glandular cells', 'salivary gland - glandular cells', 'seminal vesicle - glandular cells', 'skeletal muscle - myocytes', 'skin 1 - fibroblasts', 'skin 1 - keratinocytes','skin 1 - Langerhans', 'skin 1 - melanocytes', 'skin 2 - epidermal cells', 'small intestine - glandular cells', 'smooth muscle - smooth muscle cells', 'soft tissue 1 - adipocytes','soft tissue 1 - chondrocytes', 'soft tissue 1 - fibroblasts', 'soft tissue 1 - peripheral nerve', 'soft tissue 2 - adipocytes', 'soft tissue 2 - chondrocytes', 'soft tissue 2 - fibroblasts','soft tissue 2 - peripheral nerve', 'spleen - cells in red pulp', 'spleen - cells in white pulp', 'stomach 1 - glandular cells', 'stomach 2 - glandular cells', 'testis - cells in seminiferous ducts','testis - Leydig cells', 'thyroid gland - glandular cells', 'tonsil - germinal center cells', 'tonsil - non-germinal center cells', 'tonsil - squamous epithelial cells', 'urinary bladder - urothelial cells','uterus 1 - cells in endometrial stroma', 'uterus 1 - glandular cells', 'uterus 2 - cells in endometrial stroma', 'uterus 2 - glandular cells', 'vagina - squamous epithelial cells'}
type='.mat';
m_file=strcat(datafile,type);
fail_task=cell(gene_size,83);
result_gene=83*ones(size(all_ess_gene,1),1);
flag_gene=zeros(size(all_ess_gene,1),83);
%result_reac=83*ones(size(all_ess_reac,1),1);
addpath('D:\MATLAB\R2014a\toolbox\RAVEN');
rmpath('D:\MATLAB\R2014a\toolbox\COBRA\cobratoolbox\src\reconstruction\refinement');
for j=1:83
%for j=61:61
    load(datafile{j});
%   [taskReport,essentialRxns]=checkTasks(model,[],true,false,false,task);
    %%{
    for i=1:size(all_ess_gene,1)
        Rgene=all_ess_gene(i,1);
        if(ismember(Rgene,model.genes))
            Model_reduced=removeGenes(model,Rgene);
            taskReport=checkTasks(Model_reduced,[],true,false,false,task);
            t=find(taskReport.ok==0)
            if t
                result_gene(i,1)=result_gene(i,1)-1;
                flag_gene(i,j)=-1;
                fail_task(i,j)={t};
            else
                flag_gene(i,j)=1;
            end
        end
    end  
end
rmpath('F:\重现工作\83种细胞网络');
rmpath('D:\MATLAB\R2014a\toolbox\RAVEN');
addpath('D:\MATLAB\R2014a\toolbox\COBRA\cobratoolbox\src\reconstruction\refinement');
clear type taskReport Model Model_reduced i j k ans