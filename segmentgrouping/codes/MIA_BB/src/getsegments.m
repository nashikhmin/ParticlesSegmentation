function segments = getsegments(points)
% points = points(2:end-1,:);
% n = size(points,1);
% nLines = round((n+5)/10);
% joins = round(linspace(1, n, nLines+1)); 
% segments = [];
% for i=1:nLines
%    segments(i,:) = points(joins(i),:);
% end
if (size(points,1)>7)
    segments = points(3:end-2,:);
else
    segments=points;
end

