function segments = mia_cmbseg(segin)
% combine the segments belong to boundaries of holes inside the objects
% with the segments of objects boundaries. 
%   Authors
%          Sahar Zafari <sahar.zafari(at)lut(dot)fi>
%
%   Changes
%       14/11/2016  First Edition
%----------------------------------------------------------------------------------------
    if length(segin) > 1
       temp = segin{1};
       for l=2:length(segin)
         temp = [temp,segin{l}];
       end
      segments = [temp];
      for kk = 1:size(segments,2)
        segments(2,kk) = {kk}; 
      end
     else
     segments = [segin{1}];
    end

end
        



