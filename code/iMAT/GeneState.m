function [ SampleGeneState ] = GeneState( specify_gene_expression )
%GENESTATE Summary of this function goes here
%  Detailed explanation goes here
    [row column]=size(specify_gene_expression);
    for j=1:column
        temp=specify_gene_expression(:,j);
        temp(find(temp==0))=[];
        temp_mean=mean(temp);
        temp_std=std(temp);
        %Q1=prctile(temp,25);
        %Q3=prctile(temp,75);
        highThreshold=temp_mean+temp_std/2;
        lowThreshold=temp_mean-temp_std/2;
        for i=1:row
            if(specify_gene_expression(i,j)<=0.001)
                SampleGeneState(i,j)=0;
            else
                if(specify_gene_expression(i,j)>=highThreshold)
                %if(specify_gene_expression(i,j)>=Q3)
                    SampleGeneState(i,j)=1;
                else
                     if(specify_gene_expression(i,j)<=lowThreshold)
                     %if(specify_gene_expression(i,j)<=Q1)
                        SampleGeneState(i,j)=-1;
                     else
                         SampleGeneState(i,j)=0;
                     end
                end
            end
        end
    end

end



% function [ SampleGeneState ] = GeneState( specify_gene_expression )
% %GENESTATE Summary of this function goes here
% %   Detailed explanation goes here
%     [row,colum]=size(specify_gene_expression);
%     for i=1:row
% %         temp=specify_gene_expression(j,:);
% %         temp(find(temp==0))=[];
% %         SampleGeneState(j,1)=mean(temp);
%         temp=specify_gene_expression(i,:);
%         temp(find(temp==0))=[];
%         temp_mean=mean(temp);
%         temp_std=std(temp);
%         highThreshold=temp_mean+temp_std/2;
%         lowThreshold=temp_mean-temp_std/2;
% %     end
% % 
% %         temp_std=std(temp);
% %         highThreshold=temp_mean+temp_std/2;
% %         lowThreshold=temp_mean-temp_std/2;
%         for j=1:colum
%             if(specify_gene_expression(i,j)<=0.001)
%                 SampleGeneState(i,j)=0;
%             else
%                 if(specify_gene_expression(i,j)>=highThreshold)
%                     SampleGeneState(i,j)=1;
%                 else
%                      if(specify_gene_expression(i,j)<=lowThreshold)
%                         SampleGeneState=-1;
%                      else
%                          SampleGeneState(i,j)=0;
%                      end
%                 end
%             end
%         end
%     end
% end
