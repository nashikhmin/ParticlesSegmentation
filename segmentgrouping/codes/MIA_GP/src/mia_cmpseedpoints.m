function segin = mia_cmpseedpoints(segin,I,radii)
% mia_nst performs normal symmetry transform to each edge segments .

%   Synopsis
        %       segin = mia_cmpseedpoints(segin,I,radii)
%   Description
%               compute the seed points as the average of the symmetry contributions

%   Inputs 
        %         - segin     a cell array containing the edge segments
        %         - I          grayscale image
        %         - radii      radial range
     
                

%   Outputs
%                   - segin     a cell array contating the detected  
%                               seedpoint and coresponding edge segments.
%         
%   Authors
%          Sahar Zafari <sahar.zafari(at)lut(dot)fi>
%
%   Changes
%       14/11/2016  First Edition
%----------------------------------------------------------------------------------------
    nmsegs = length(segin);
    for jj = 1:nmsegs
        nmcc = size(segin{jj},2);
        for ii=1:nmcc
            segment = segin{jj}{1,ii};
            segin{jj}{2,ii} = ii;
            segin{jj}{3,ii} = [1,1];
        end
    end
end
