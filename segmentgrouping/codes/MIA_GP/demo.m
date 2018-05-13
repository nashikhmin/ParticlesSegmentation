% addpath
warning off
config


for i=12:12
    imgName = strcat('img', num2str(i,'%03d'));
    imgExt = '.png';
    imggry = imread(strcat(imgName,imgExt));
    imggry = uint8(imggry);
    % load the method parameters
    
    param = readparam();
    
    %it can be 'synthetic', 'real', 'no'
    validation = 'synthetic';
    resultPath = '../../Results/';
    
    fprintf('Segmentation of Overlapping Nanoparticles Using Branch and Bound Algorithem with Modificated Cost Function.....\n')
    fprintf('Process started.....\n')
    tic
    % call segmentation function
    mia_particles_segmentation(imggry,param,imgName,resultPath,validation);
    toc
end
