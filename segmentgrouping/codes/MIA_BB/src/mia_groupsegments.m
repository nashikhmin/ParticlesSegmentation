function contourevidence = mia_groupsegments(segin)
% mia_groupsegments groups the contour segments.

%   Synopsis
%       contourevidence = mia_groupsegments(segin)
%   Description
%       combines the contour segments that belgone to the same objects. 

%   Inputs 
%         - segin       contour segments

%   Outputs
%         - contourevidence  combined contour segments.
%         
%   Authors
%          Sahar Zafari <sahar.zafari(at)lut(dot)fi>
%
%   Changes
%       14/11/2016  First Edition
%----------------------------------------------------------------------------------------
    contourevidence = [];
    for ii=1:length(segin)
        contourevidence = [contourevidence;segin{ii}];
    end
end
