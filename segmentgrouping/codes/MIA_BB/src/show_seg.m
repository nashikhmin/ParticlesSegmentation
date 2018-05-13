function  show_seg(seg)
figure
hold on
p=[];
for i=1:size(seg,2) 
   p = [p; seg{1,i}]; 
end
polygon = polyshape(p(:,1),p(:,2));
plot(polygon);

for i=1:size(seg,2)
    plot(seg{i}(:,1),seg{i}(:,2));
end

end

