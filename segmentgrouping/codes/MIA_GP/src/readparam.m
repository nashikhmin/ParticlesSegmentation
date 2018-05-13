function [Paramethod] = readparam(varargin)
%          - k         kth adjucnet points to the corner point
%         - rmin       minmum radial size
%         - rmax       maximum radial size
%         - aplha      weighing parameter for concavity
%         - beta       weighing parameter for elipcity
%         - gamma      weighing parameter for symmetry
%         - vis1       0 or 1, to visualize the contour evidenc extraction
%                       step
%         - vis2       0 or 1, to visualize the contour estimation
%                       step
Paramethod=[15,10,20,0.4,0.1,0.5,1,1];
