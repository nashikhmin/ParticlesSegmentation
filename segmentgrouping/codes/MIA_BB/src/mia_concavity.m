function jcon = mia_concavity(segin,I)
% mia_cmpdistance measure the concavity of contour segments to be grouped.

%   Synopsis
        %        jcon = mia_concavity(segin,I)
%   Description
            %  Given two contour segments Si and Sj the the concavity
            %  define as (1-(Asisj))
          
%   Inputs 
            % - segin     a cell array containing the contour segments
   

%   Outputs
            % jcon        concavity cost
%         
%   Authors
%          Sahar Zafari <sahar.zafari(at)lut(dot)fi>
%
%   Changes
%       14/11/2016  First Edition
%----------------------------------------------------------------------------------------

    nmss = length(segin);
    if nmss==1
        bnd = [segin{1};segin{1}(1,:)];
        Asc = polyarea(bnd(:,2),bnd(:,1));
        x = bnd(:,2);
        y = bnd(:,1);
        if (collinear([x;y],1e-17))
            jcon = 0;
        else
            [idx, Aconhullsc] = convhull(x,y); 
            jcon = ((1-(Asc/Aconhullsc)));
        end
 
    else
        bnd = [];
        for ii=1:nmss-1
            bnd = [bnd;segin{ii};segin{ii+1}(1,:)];
        end
        bnd = [bnd;segin{nmss};segin{1}(1,:)];
        Asc = polyarea(bnd(:,2),bnd(:,1));  
        x = bnd(:,2);
        y = bnd(:,1);
         [idx, Aconvhullsc] = convhull(x,y); 
         jcon = 1-(Asc/Aconvhullsc);
    end
%      if vis
%         se = strel('disk',1);
%         I = imerode(I,se);
%         imshow(I); hold on
%         plot(bnd(:,2),bnd(:,1),'.r'); hold on
%         plot(x(idx),y(idx),'g-','markersize',16)
%     end
end
