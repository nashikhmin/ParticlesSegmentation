function img = draw_circle(radius)

img = zeros(radius*2+1);

[x y]= find(img==0);

xc=radius+1;
yc=radius+1;

r=radius.^2;

d=find(((x-xc).^2+(y-yc).^2) <= r);

for i=1:size(d,1)
  img(x(d(i)),y(d(i)))=1;
end