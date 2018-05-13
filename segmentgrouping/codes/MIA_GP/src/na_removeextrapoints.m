function [xc,yc,idxpp] = na_removeextrapoints(idx,curve,mask,k)
% mia_removeconvexcorner remove the convex corner.

%   Synopsis
%       [xc,yc,idxpp] = mia_removeconvexcorner(idx,curve,mask)
%   Description
%        Returns the concave points in objects boundary.The corner 
%        point pi is qualified as concave if the line
%        connecting p i−k to p i+k does not reside inside 
%        contour segmentation and segment grouping
%   Inputs 
%         - idx      index of detected corener in the input image.    
%         - curve   objects boundareis
%         - mask    binar mask of image
%         - k       kth adjacent contour points
%   Outputs
%        - idxpp  index of detected concave in the input image.
%        - xc     x coordinate of concave points.
%        - yc     y coordinate of concave points.


%                           
%   Authors
%          Sahar Zafari <sahar.zafari(at)lut(dot)fi>
%
%   Changes
%       14/01/2016  First Edition
%----------------------------------------------------------------------------------------
     xc = []; yc = [];
     se = strel('disk',3); 
     mask = imdilate(mask,se);
    [nmrows, nmcols] = size(mask);
    
    idxpp = [];
    for i=1:length(idx)
        idxpp{i}=[];
    end
    l = 0;
    for i = 1:size(idx,2)
        if length(idx{i})== 0
            idxpp{i}=[];
        end
         for j = 1:length(idx{i})
            idxi =idx{i}(j);
            x = curve{i}(idxi,2);
            y = curve{i}(idxi,1);
          if (j>1) && (abs(idxi-idxpp{i}(j-1))<18)
                bi = int32(mean([idxi idxpp{i}(j-1)]));
                idxpp{i}(j-1) = bi;
                x = curve{i}(bi,2);
                y = curve{i}(bi,1);
                xc(l) = x;
                yc(l) = y;
              
                idxpp{i}(j) = 0;
              continue;
          else
              l = l+1;
              xc(l) = x;
              yc(l) = y;
              idxpp{i}(j) = idxi;
         end

        end
    end
    for i=1:length(idxpp)
      if  ~isempty(idxpp{i})
       idxpp{i}(idxpp{i}==0)=[];
      end
    end
    
    end
