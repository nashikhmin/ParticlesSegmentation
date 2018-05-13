% An example script to generate a set of images with ground truth

clear all; close all;

% image directory
imgdir = '../../Dataset/';

% number of images
nimages = 3;

% run configure script
configure;

for i = 1: nimages
  fprintf('\rImage: %d/%d   ', i, nimages);

  % generate an artificial image and the corresponding ground truth
  [img, gtimg, gtparam] = gen_img(cfg);

  % save the image and ground truth
  filename = ['img', num2str(i,'%03d')];
  imwrite(img, [imgdir, filename, '.png']);
  save([imgdir, filename, '.mat'], 'gtimg', 'gtparam');
end;
fprintf('\n')