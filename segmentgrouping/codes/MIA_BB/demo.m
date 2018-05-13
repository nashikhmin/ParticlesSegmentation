% addpath
warning off
config


for i=4:11
    imgName = strcat('realimage', num2str(i,'%02d'));
    imgExt = '.png';
    imggry = imread(strcat(imgName,imgExt));
    imggry = uint8(imggry);
    % load the method parameters
    
    param = readparam();
    
    %it can be 'synthetic', 'real', 'no'
    validation = 'real';
    resultPath = '../../Results/BB/';
    
    fprintf('Segmentation of Overlapping Nanoparticles Using Branch and Bound Algorithem with Modificated Cost Function.....\n')
    fprintf('Process started.....\n')
    tic
    % call segmentation function
    mia_particles_segmentation(imggry,param,imgName,resultPath,validation);
    toc
end
