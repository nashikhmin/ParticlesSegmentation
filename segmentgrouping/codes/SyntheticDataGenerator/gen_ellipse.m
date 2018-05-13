% 
%  cfg.widthrange
%  cfg.lengthrange
%  cfg.randorient
%  cfg.orientation
function [img, boundaries] = gen_ellipse(imsize,cfg)

circle = draw_convex_hull(100);


esize = [rand * diff(cfg.widthrange) + cfg.widthrange(1), ...
         rand * diff(cfg.lengthrange) + cfg.lengthrange(1)];

if cfg.randorient        
  rotation = floor(rand*360);
else
  rotation = cfg.orientation;
end;

ellipse = imresize(circle,esize,'bilinear');
ellipse = imrotate(ellipse,rotation,'bilinear','loose');
ellipse = ellipse(sum(ellipse'>0.5)>0,sum(ellipse>0.5)>0);

img = logical(zeros(imsize));

x = floor(rand*(imsize(2)-size(ellipse,2)))+1;
y = floor(rand*(imsize(1)-size(ellipse,1)))+1;
img(y:y+size(ellipse,1)-1,x:x+size(ellipse,2)-1) = ellipse > 0.5;


boundaries = bwboundaries(img);
boundaries = boundaries{1};


function img = draw_convex_hull(radius)

img = zeros(radius*2+1);
size_variation = [3,4,100];
n = size_variation(randi(size(size_variation)));
ranges = linspace(0,2*pi,n+1);
t = [];
for i =1:n
    t = [t rand()*(2*pi/(n+1))+ranges(i)];
end
t = t';
xy = [radius*cos(t)+101,radius*sin(t)++101];
tess = convhulln(xy);
[x, y]= find(img==0);
in = inhull([x y],xy,tess);
d=find(in);

for i=1:size(d,1)
  img(x(d(i)),y(d(i)))=1;
end