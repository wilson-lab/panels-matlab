
%clear all
load 'protocolStruct20140717_15-46.mat';
a = tic;
for j = 1:100
for i = 1:length(protocolStruct.stim)
    abc = protocolStruct.stim(i).matCell;
    %abc = protocolStruct.stim(1).matCell;
    patVectorMatrix = convertPatternMatrixMex1(abc);
end
end

time = toc(a)/(144*31*100)
