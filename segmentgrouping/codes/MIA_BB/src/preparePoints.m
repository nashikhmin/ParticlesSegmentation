function [resultPoints] = preparePoints(pointsOriginal)
resultPoints = [];
for i=1:size(pointsOriginal,2)
    points = pointsOriginal{i};
    %points = sortPoints(points);
    points(:,3)=i;
    resultPoints{i} = points;
end
end

