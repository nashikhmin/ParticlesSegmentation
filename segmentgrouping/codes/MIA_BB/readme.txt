Microscopy Image Analysis (MIA) toolbox for segmentation of overlapping convex objects in microscopy images.
% Version 1.0 15-Nov-2016
The toolbox contains the following folders:
src:

	%   mia_cmbseg 		         - Combines the segments belong to boundaries of holes inside the objects with the segments of objects boundaries.
	%   mia_cmpadd                   - Computes the discrepancy between the fitted curve and the contour points. 
	%   mia_cmpconcavepoint_css 	 - Performs concave point extraction.
	%   mia_contourevidence 	 - Performs contour evidenc extraction step of the method.
	%   mia_cmpdistance  		 - Computes the distance betwwen fitted ellipses.
        %   mia_cmpgroupingcost 	 - Computes the cost function.
        %   mia_cmpseedpoints 	         - Computes the seedpoints for each edge segments by normal symmetry transform.
        %   mia_concavity 	         - Computes the concavity cost.
        %   mia_concvptobnd	         - Assigns each detected concave point on the curve to the boundaries.
        %   mia_ellipticity 		 - Computes the ellipticity cost.              
        %   mia_gencandidatesol          - Generates the candidate solutions.
        %   mia_groupsegments            - Groups the contour segments.
	%   mia_groupsegments_bb 	 - Performs segment grouping sub-step of the method based on the branch and bound algorithem.
        %   mia_iscp                     - Checks if there is cp points between the contour segments.
	%   mia_nst                      - Performs normal symmetry transform to edge segments
	%   mia_removeconvexcorner       - Removes the convex corner.
	%   mia_segmentcurve             - Splits the curve into contour segments.
	%   mia_estimatecontour		 - Esitmates the objects boundaries by ellipse fitting.

	% Demos
	%   readparam                   - Reads the method parameters.
	%   config                      - Adds necessary path.
	%   demo                        - Demonstrates all the method steps in one example image.
	%   mia_particles_segmentation  - Performs segmentation by using the branch and bound algorithem.
lib: 
	% modified/available matlab codes or toolbox
	%   mia_curve_tangent 		  -Estimates the curve tangent.
	%   mia_get_corner  		  -Computes the corner in the image.
	%   mia_extract_curve 		 - Extracts the curve in the image.
	%   mia_beresenham               - Creats a line beetween two point based on bresenham algorithm.
	%   mia_cmpparam      		 - Returns the paramters of ellipses fitted to the evidences.
	%   mia_fitellip_lsf     	 - Returns the 6 parameter vector of the algebraic circle fit
	%                        	   to a(1)x^2 + a(2)xy + a(3)y^2 + a(4)x + a(5)y + a(6) = 0.
	%   mia_drawellip_lsf      	 - Draw the ellipse by 100 points.
	%   mia_solveellipse_lsf         - Returns the ellipse parameters [r1 r2 cx cy theta].
        %   mia_linenormals2D            - Calculates the normals of the line points.


img:
      % the input images


% References:

%   [1] Zafari, S.; Eerola, T.; Sampo, J.; Kalviainen, H.; Haario, H.,
%   "Segmentation of Partially Overlapping Nanoparticles Using Branch and Bound Algorithem," (ACCV 2016), 2016.


% Author(s):

%    Sahar Zafari <sahar.zafari@lut.fi>

%  Please, if you find any bugs contact the authors.


