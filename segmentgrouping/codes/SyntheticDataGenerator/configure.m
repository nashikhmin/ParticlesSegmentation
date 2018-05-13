% An example configure script for gen_img

% size of the generated image
cfg.imsize = [500,700];

% number of the objects in the image
cfg.nobjects = 25;

% maximum overlap between two objects
cfg.maxoverlap = 0.4; % 30%

% The name of the function to generate a single object.
% The function should have to following form:
%   [objectimg, gtparam] = function(imsize, objectcfg)
% input: imsize (size of the generated image), cfgobject (configure struct 
%        that contain all the necessary parameters to generate the object)
% output: objectimg (a logical array where pixels representing the object have 
%         value 1 and other pixels have value 0), gtparam (a struct containing
%         the parameters of the genrated object)
% Note that the output image should have the same size as the size of the final
% generated image.
cfg.objectfunc = 'gen_ellipse';

% Parameters for the function that generates the object

% gen_ellipse parameters:
cfg.objectcfg.widthrange = [60,200]; % min and max width of an ellipse
cfg.objectcfg.lengthrange = [60,200]; % min and max length of an ellipse
cfg.objectcfg.randorient = 1; % 0: fixed orientation, 1: random orienatation
cfg.objectcfg.orientation = 0; % orienation (degrees) in the case of fixed orientation
