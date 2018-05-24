function segments = getsegments(points)
if (size(points,1)>7)
    segments = points(3:end-2,:);
else
    segments=points;
end

