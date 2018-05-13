clear all; close all;

% run configure script
configure;

% generate an artificial image and the corresponding ground truth
[img, gtimg, gtparam] = gen_img(cfg);

figure(1);
imshow(img);
drawnow

% show the ground truth

% RGB version of the original image
img_rgb(:,:,1) = double(img);
img_rgb(:,:,2) = double(img);
img_rgb(:,:,3) = double(img);

for i = 1:length(gtparam)
  % ground truth segmentation
  gtsegment = gt_segment(gtimg,i);
  
  % draw segment edges to the original image
  [edgey,edgex] = find(edge(gtsegment));
  for j = 1:length(edgey)
    img_rgb(edgey(j),edgex(j),1) = 1;
    img_rgb(edgey(j),edgex(j),2) = 0;
    img_rgb(edgey(j),edgex(j),3) = 0;
  end;
end;

figure(2);
imshow(img_rgb);


