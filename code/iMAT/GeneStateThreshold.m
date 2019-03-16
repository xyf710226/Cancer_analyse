function [ ModelGeneState ] = GeneStateThreshold( AllSamGeState )
%GENESTATETHRESHOLD Summary of this function goes here
%   Detailed explanation goes here
     [row column]=size(AllSamGeState);
     for i=1:row
       
         OneNum=length(find(AllSamGeState(i,:)==1));
         ZeroNum=length(find(AllSamGeState(i,:)==0));
         NegOneNum=length(find(AllSamGeState(i,:)==-1));
         if(OneNum>NegOneNum)
             maxTemp=OneNum;
             ModelGeneState(i)=1;
         else
             maxTemp=NegOneNum;
             ModelGeneState(i)=-1;
         end
         if(maxTemp<=ZeroNum)
             ModelGeneState(i)=0;
         end
     end

end

% function [ ModelGeneState ] = GeneStateThreshold( AllSamGeState )
% %GENESTATETHRESHOLD Summary of this function goes here
% %   Detailed explanation goes here
%      [row,colum]=size(AllSamGeState);
%      for i=1:row
%        
%          OneNum=length(find(AllSamGeState(i,:)==1));
%          ZeroNum=length(find(AllSamGeState(i,:)==0));
%          NegOneNum=length(find(AllSamGeState(i,:)==-1));
%          if(OneNum>=0.5*colum)
%              ModelGeneState(i)=1;
%          else
%              ModelGeneState(i)=0;
%          end
%          if(NegOneNum>=0.5*colum)
%              ModelGeneState(i)=-1;
%          else
%              ModelGeneState(i)=0;
%          end         
%      end
% 
% end
