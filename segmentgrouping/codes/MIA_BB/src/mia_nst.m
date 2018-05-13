function [xseed,yseed] = mia_nst(I,segin,normvec,radii)
% mia_nst performs normal symmetry transform to edge segments .

%   Synopsis
        %       On = mia_cmpseedpoints_frst( image, radii, alpha, stdFactor, mode )
%   Description
%           NST every contour segment point gives a vote for the plausible radial
%           symmetry at some specific distance from that point. 
%               

%   Inputs 
           
        %         - I          image
        %         - segin      edge segment
        %         - normvec    normal vector of edge segment
        %         - radii      radial range
 
%   Outputs
%              - [xseed,yseed]  location of seedpoints    
%         
%   Authors

% ------------------------------------------------------------------------
    imgsize = size (I);
    nmseg = length(segin);
    radiusIndex = 1;
    On = zeros(imgsize);
    for n = radii
        for i = 1:nmseg
            p = segin(i,:);
            g = normvec(i,:); % the gradient at pixel p
            gnorm = sqrt( g * g' ) ;
            gp = (round((g./gnorm) * n));
            ppve = p - gp; 
             if isnan(ppve)
                continue;
            end
            On(ppve(1), ppve(2)) = On(ppve(1), ppve(2)) - 1;
        end
        On = abs(On);
        On = On ./ max(On(:)); 
        radiusIndex = radiusIndex + 1;
    end
    indx = find(On==max(On(:)));
    [xseed,yseed] = ind2sub(imgsize,indx);
    xseed = round(mean(xseed));
    yseed = round(mean(yseed));
end
