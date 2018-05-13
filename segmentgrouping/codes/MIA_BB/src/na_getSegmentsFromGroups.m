function segments = na_getSegmentsFromGroups(groups)
n = size(groups);
segments = [];
for i=1:n
    segments=[segments groups{i}{2}];
end
end

