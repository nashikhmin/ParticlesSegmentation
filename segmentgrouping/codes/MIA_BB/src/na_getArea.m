function area = na_getArea(segments)
area = 0;
points = [];
for i=1:size(segments,2)
    points = [points;segments{1,i}];
end

area=polyarea(points(:,1),points(:,2));

