function  mia_particles_segmentation(I,param,im_name,result_path,validation)
% mia_particles_segmentation performs segmentation using the branch and bound method.
%   Synopsis
%      stats = mia_particles_segmentation(I,param)
%   Description
%         Returns segmentation result (objects boundaries) of overlapping
%         nanoparticles.
%   Inputs 
%          - I         grayscale or binary Image
%          - k         kth adjucnet points to the corner point
%         - rmin       minmum radial 
%         - rmax       maximum radial
%         - aplha      weighing parameter for concavity
%         - beta       weighing parameter for ellipticity
%         - gamma      weighing parameter for symmetry
%        - vis1        visualize the contoure evidence extraction step
%        - vis2        visualize the contoure estimation step
%   Outputs
%         - stats      cell array contating the objects boundaries 

%         
%   Authors
%          Sahar Zafari <sahar.zafari(at)lut(dot)fi>
%
%   Changes
%       14/11/2016  First Edition
%----------------------------------------------------------------------------------------
    % load the parameters
    k     = param(1);
    rmin  = param(2);
    rmax  = param(3);
    alpha = param(4);
    beta  = param(5);
    gamma = param(6);
    vis1  = param(7);
    vis2  = param(8);
    % Image Binarization by otsu's method
    level = graythresh(I);
    imgbw =  ~im2bw(I,level);
    % Contour Evidence Extraction
    fprintf('Performs Contour Evidence Extraction\n')
    mia_cmpcontourevidence_bb(imgbw,k,rmin,rmax,alpha,beta,gamma,vis1,im_name,result_path,validation);
    % Contour Estimation
    %fprintf('Performs Contour Estimation\n')
    %stats =  mia_estimatecontour_lsf(I,contourevidence,vis2);
end
