function [idxconcavepoints,xcp,ycp, bnd]= mia_cmpconcavepoint_css(I,bnd,C,T_angle,sig,H,L,Endpoint,Gap_size,k,vis)
% mia_cmpconcavepoint_css performs concave point extraction.
%   Synopsis
%       [idxconcavepoints,xcp,ycp, bnd]= mia_cmpconcavepoint_css(I,C,T_angle,sig,H,L,Endpoint,Gap_size,vis)
%   Description
%       Returns the the concave points and boundaries of the object.
%       After extracting the image edge by canny edge detector, the
%       concave points are obtained through the detection of corner
%       points followed by the concavity test. The corner points
%       are detected using the modified curvature  scale space (CSS)
%       method based on curvature analysis.
%   Inputs
%        - I        Binary Image
%        - bnd      boundaries of the objects
%        - C        denotes the minimum ratio of major axis to minor axis of an ellipse,
%                   whose vertex could be detected as a corner by proposed detector.
%                   The default value is 1.5.
%       - T_angle   denotes the maximum obtuse angle that a corner can have when
%                   it is detected as a true corner, default value is 162.
%      - Sig        denotes the standard deviation of the Gaussian filter when
%                   computeing curvature. The default sig is 3.
%      - H,L        high and low threshold of Canny edge detector. The default value
%                   is 0.35 and 0.
%      - Endpoint   a flag to control whether add the end points of a curve
%                   as corner, 1 means Yes and 0 means No. The default value is 1.
%      - Gap_size   a paremeter use to fill the gaps in the contours, the gap
%                   not more than gap_size were filled in this stage. The default
%                   Gap_size is 1 pixels.
%        - k        kth adjucnet points to the corner point
%      - vis        0 or 1 for visualization puropose
%   Outputs
%         - idxconcavepoints   cell array contating the index of detected
%                              concave in the input image.
%         - xcp               x coordiante of concave points
%         - ycp               y coordiante of concave points
%         - bnd              cell array contating the boundries

%   Authors
%          Sahar Zafari <sahar.zafari(at)lut(dot)fi>
%
%   Changes
%       14/11/2016  First Edition

% detect corner points by CSS
%   Composed by He Xiaochen
%   HKU EEE Dept. ITSR, Apr. 2005
%
%   Algorithm is derived from :
%       X.C. He and N.H.C. Yung, Curvature Scale Space Corner Detector with
%       Adaptive Threshold and Dynamic Region of Support, Proceedings of the
%       17th International Conference on Pattern Recognition, 2:791-794, August 2004.
%----------------------------------------------------------------------------------------

%preprocessing to smooth the objects boundarries
se = strel('disk',3);
se1 = strel('disk',3);
I2 = imerode(I,se);
I2 = imdilate(I2,se1);
I2 = bwmorph(I2,'majority'); 

% extracting the image edge by canny
BW = edge(I2,'canny');
% extracts corners in image  by css
[curve,curve_start,curve_end,curve_mode,curve_num]=mia_extract_curve(BW,Gap_size);  % Extract curves

if (curve_num==0)
    idxconcavepoints=[];
    xcp=[];
    ycp=[];
    bnd=[];
    return
end
%[cp, idx] = mia_get_corner2(curve); % Detect corners
[~,~,idx]=mia_get_corner(curve,curve_start,curve_end,curve_mode,curve_num,BW,5,Endpoint,C,T_angle); % Detect corners
[xc,yc,idxc] = mia_removeconvexcorner(idx,curve,I2,k);
%[xc,yc,idxc] = na_removeextrapoints(idx,curve,BW,k);

%     %REMOVE OLD CODE
%     [~,~,idx]=mia_get_corner(curve,curve_start,curve_end,curve_mode,curve_num,BW,5,Endpoint,C,T_angle); % Detect corners
%     % remove the detected convex corners
%     [xc,yc,idxc] = mia_removeconvexcorner(idx,curve,I2,k);


%[idxconcavepoints,xcp,ycp, bnd] = mia_concvptobnd(curve,xc,yc,idxc);
%    x1 = bnd{1,1};
%   y1 = curve{1,1};
%  z=0;
idxconcavepoints = idxc;
bnd = curve';
xcp = xc;
ycp = yc;
end
