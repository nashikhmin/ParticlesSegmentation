% each data sample contains the following information:
% gtparam : contains groundtruth boundaries, partial boundaries,.. and object centeroid
% imggry : original grayscale image
% imgbw : original binay image
% xc, yc : concave points coordiantes
% segmentscc : contour segments for each connectec component in the...
% image first row is the coordinates of contour segments, second is the
% id and third row is the seedpoints

clc; clear; close all;

for i=1:11
    imNum =  num2str(i,'%02d');
    load(strcat('sample',imNum));
    imageName = strcat('../../Dataset/realimage_orig',imNum);
    col_seg = lines(500); 
    n_fig = 1;

    % to plot the contour segments  (this is the data)
    % figure(n_fig)
    % n_fig = n_fig + 1;
    % imshow(imggry); hold on 
    % for i=1:size(segmentscc,2) 
    %     for j=1:size(segmentscc{i},2)
    %         plot(segmentscc{i}{1,j}(:,2),segmentscc{i}{1,j}(:,1),'o','color',col_seg(j,:,:),'markerfacecolor',col_seg(j,:,:));hold on
    %     end
    %      plot(xc{i},yc{i},'o','color','g','markerfacecolor','g');hold on
    %     
    % end
    % title ('Contour Segments')

    % to plot the partial boundaries (this is our end goal) 
    % figure (n_fig),imshow(imggry); hold on
    % n_fig = n_fig + 1;

    gtparam1 = [];
    for i=1:length(gtparam)
        [y,x] = ind2sub(size(imgbw),gtparam(i).boundary);
        gtparam1{i}=[x';y']';
        %plot(x,y,'o','color',col_seg(i,:,:),'markerfacecolor',col_seg(i,:,:));hold on
    end

    gtparam = gtparam1;


    imFile = strcat(imageName,'.png');
    imwrite(imggry,imFile);
    save(imageName,'gtparam','segmentscc','xc','yc');
end