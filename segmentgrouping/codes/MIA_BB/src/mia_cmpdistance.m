function distance = mia_cmpdistance(Oi,Oj,mask)

% mia_cmpdistance compute the distance between two seedpoints.

%   Synopsis
        %       distance  = mia_cmpdistance(xys,xye,mask)
%   Description
            %  The distance function g(Oi ,  oj ) is defined as the
            %  distance from the seedpoint Oi to the seedpoint 
            %  seedpoint Oj , while it is assumed that all the
            %  pixel points on the line connecting the edge point to the
            %  seedpoint l(Oi , Oj ) reside in the foreground region of
            %  the image silhouette

%   Inputs 
            % - Oi     xy coordinates of first seedpoint
            % - Oj     xy coordinates of  second seedpoint
            % - mask    binary mask image     

%   Outputs
            % distance        distance value
%         
%   Authors
%          Sahar Zafari <sahar.zafari(at)lut(dot)fi>
%
%   Changes
%       14/11/2016  First Edition
%----------------------------------------------------------------------------------------

   [nmrows, nmcols] = size(mask);
   mask = imdilate(mask,strel('disk',1));
   distance =  pdist([Oi;Oj]);
   distance = mean(distance);
   distance = (distance)/(40);
   [psubx,psuby]=mia_bresenham(Oi(2),Oi(1),Oj(end,2),Oj(end,1));
   pidx = sub2ind([nmrows, nmcols], psuby, psubx);
   if any(mask(pidx)==0)
       distance = inf;
   end   

end
