function jelp = mia_ellipticity(segin)
% mia_ellipticity computes the ellipticity cost.
%   Synopsis
%       jelp = mia_ellipticity(segin)
%   Description
%          measuring the discrepancy between the fitted
%          ellipse and the contour segments by computing ADD value.
%   Inputs 
%          - segin         a cell array containing the contour segment
%   Outputs
%         - jelp           ellipticity cost 
%
%         
%   Authors
%          Sahar Zafari <sahar.zafari(at)lut(dot)fi>
%
%   Changes
%       14/11/2016  First Edition
%----------------------------------------------------------------------------------------



    nmss = length(segin);
    if nmss==1
        bnd = [segin{1}];
        eparam = mia_cmpparam(bnd');
        jelp = mia_cmpadd(bnd',eparam);
    else
        bnd = [];
        for ii=1:nmss
            bnd = [bnd;segin{ii}];
        end
        eparam = mia_cmpparam(bnd');
        jelp = mia_cmpadd(bnd',eparam);
              
    end
end
