function J = mia_cmpgroupingcost(segin,seeds,cp,alpha,beta,gamma,I)
% mia_cmpgroupingcost compute the grouping cost J.

%   Synopsis
        %        J = mia_cmpgroupingcost(segin,seeds,cp,I)
%   Description
%              grouping cost is a hybrid cost function consisting of
%              two parts: 1) generic part (Jcon) that encapsulate the 
%              general convexity properties of the objects and 2) specific
%              part that encapsulates the properties of objects symmetry 
%              (Jsymm) and ellipticity (Jelp).
          
%   Inputs 
            % - segin      a cell array containing the contour segments
            % - seeds      a cell array containing the seedpoints
            % - aplha      weighing parameter for concavity
            % - beta       weighing parameter for elipcity
            % - gamma      weighing parameter for symmetry
            % - cp         a cell array containing the concave points
            % - I          binary image
   

%   Outputs
            % J        cost value
%         
%   Authors
%          Sahar Zafari <sahar.zafari(at)lut(dot)fi>
%
%   Changes
%       14/11/2016  First Edition
%----------------------------------------------------------------------------------------
    Jcon = mia_concavity(segin,I); % concavity cost
    xyst = [];
    if length(seeds) == 1
        Jsymm = 1;
        iscp = 0;
    else
        iscp = mia_iscp(segin{1},segin{2},cp');
        if iscp == 1 % there is cp point between segments
            Jcon = iscp;
        end
        for i = 2:length(seeds)
            xyst = [xyst;seeds{i}];
        end
        Jsymm = mia_cmpdistance(seeds{1},xyst,I);
     end
    Jelp = mia_ellipticity(segin);
    J = (alpha*(Jcon))+(beta*(Jelp)+(gamma*(Jsymm)));
        
end

