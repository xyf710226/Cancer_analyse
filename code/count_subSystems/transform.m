for i=1:size(Recon3DModel.subSystems)
    system{i}=Recon3DModel.subSystems{i,1}{1,1};
end
system=system';