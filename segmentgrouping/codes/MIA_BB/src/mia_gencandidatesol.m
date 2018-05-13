function P = mia_gencandidatesol(sc, T, P, dp)
% mia_gencandidatesol generate the candidate solutions for grouping problem.
%   Synopsis
%       P = mia_gencandidatesol(sc, T, P, dp)
%   Description
%      the candidate solutions
%   Inputs 
%          - sc         index of segment
%          - T          indexs of possible segments for grouping
%          - P          previous candidate soltuions
%          - dp         depth for root node
%   Outputs
%         - P           the candidate solutions 

%         
%   Authors
%          Sahar Zafari <sahar.zafari(at)lut(dot)fi>
%
%   Changes
%       14/11/2016  First Edition
%----------------------------------------------------------------------------------------

    [x,y] = meshgrid(sc(end), T(length(T):-1:1));
    tmp = [x(:), y(:)];
    if length(sc)>1
        tmp = [repmat(sc(1:end-1),size(tmp,1),1),tmp];
    end
    tmp = mat2cell(tmp,ones(1,size(tmp,1)),size(tmp,2));
    P = [P;[tmp,num2cell(dp*ones(length(tmp),1))]];

end
