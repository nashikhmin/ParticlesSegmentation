function iscp = mia_iscp(si,sj,cp)
% mia_checkcp check if there is cp points between the contour segments.
%   Synopsis
        %        iscp = mia_checkcp(si,sj,cp)
%   Description
            %  Given two contour segments Si and Sj the mia_iscp check
            %  whether there is concave point between two contour segments
           
          
%   Inputs 
            % - si     first contour segments
            % - sj     second the contour segments
            % - cp     concave points
   

%   Outputs
            % iscp       0 or 1
%         
%   Authors
%          Sahar Zafari <sahar.zafari(at)lut(dot)fi>
%
%   Changes
%       14/11/2016  First Edition
%----------------------------------------------------------------------------------------


    iscp = 0;
    fs1 = si(1,:); ls1 = si(end,:);
    fs2 = sj(1,:); ls2 = sj(end,:);
    p1_s1 = any(all([ismember(sj(:,1),fs1(1)),ismember(sj(:,2),fs1(2))],2));
    p2_s1 = any(all([ismember(sj(:,1),ls1(1)),ismember(sj(:,2),ls1(2))],2));
    p1_s2 = any(all([ismember(si(:,1),fs2(1)),ismember(si(:,2),fs2(2))],2));
    p2_s2 = any(all([ismember(si(:,1),ls2(1)),ismember(si(:,2),ls2(2))],2));

    if p1_s1 
        iscp = any(all([ismember(cp(:,1),fs1(1)),ismember(cp(:,2),fs1(2))],2));
        if iscp
            iscp = 1;
        end
    elseif p2_s1
          iscp = any(all([ismember(cp(:,1),ls1(1)),ismember(cp(:,2),ls1(2))],2));
          if iscp
            iscp = 1;
          end
    elseif p1_s2
          iscp = any(all([ismember(cp(:,1),fs2(1)),ismember(cp(:,2),fs2(2))],2));
          if iscp
            iscp = 1;
          end
    elseif p2_s2
          iscp = any(all([ismember(cp(:,1),ls2(1)),ismember(cp(:,2),ls2(2))],2));
          if iscp
            iscp = 1;
          end
      
end


end