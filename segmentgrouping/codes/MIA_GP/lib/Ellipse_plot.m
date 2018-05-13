function [X] = Ellipse_plot(A, C, varargin)
%
%  Ellipse_Plot(A,C,N) plots a 2D ellipse or a 3D ellipsoid 
%  represented in the "center" form:  
%               
%                   (x-C)' A (x-C) <= 1
%
%  A and C could be the outputs of the function: "MinVolEllipse.m",
%  which computes the minimum volume enclosing ellipsoid containing a 
%  set of points in space. 
% 
%  Inputs: 
%  A: a 2x2 or 3x3 matrix.
%  C: a 2D or a 3D vector which represents the center of the ellipsoid.
%  N: the number of grid points for plotting the ellipse; Default: N = 20. 
%
%  Example:
%  
%       P = rand(3,100);
%       t = 0.001;
%       [A , C] = MinVolEllipse(P, t)
%       figure
%       plot3(P(1,:),P(2,:),P(3,:),'*')
%       hold on
%       Ellipse_plot(A,C)
%  
%
%  Nima Moshtagh
%  nima@seas.upenn.edu
%  University of Pennsylvania
%  Feb 1, 2007
%  Updated: Feb 3, 2007

%%%%%%%%%%%  start  %%%%%%%%%%%%%%%%%%%%%%%%%%%
N = 20; % Default value for grid

[U D V] = svd(A);

% get the major and minor axes
%------------------------------------
a = 1/sqrt(D(1,1));
b = 1/sqrt(D(2,2));

theta = [0:1/N:2*pi+1/N];

% Parametric equation of the ellipse
%----------------------------------------
state(1,:) = a*cos(theta); 
state(2,:) = b*sin(theta);

% Coordinate transform 
%----------------------------------------
X = V * state;
X(1,:) = X(1,:) + C(1);
X(2,:) = X(2,:) + C(2);
