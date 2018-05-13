% addpath
warning off
config
% load the particles image

imgName = 'demo3';
imgExt = '.png';
imggry = imread(strcat(imgName,imgExt));
imggry = uint8(imggry);
% load the method parameters

param = readparam();

%it can be 'synthetic', 'real', 'no'
validation = 'no';
resultPath = '../../Results/';

fprintf('Segmentation of Overlapping Nanoparticles Using Branch and Bound Algorithem with Modificated Cost Function.....\n')
fprintf('Process started.....\n')
tic
% call segmentation function
mia_particles_segmentation(imggry,param,imgName,resultPath,validation); 
toc

             
%ideas connection not go throw empty space
%calculate symmetry
%calculate concavity
%calculate direction of the line