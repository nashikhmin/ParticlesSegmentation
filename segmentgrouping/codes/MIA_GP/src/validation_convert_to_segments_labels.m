function result = validation_convert_to_segments_labels(shat,n)
%%Convert groups of segment to array with label for each segments
result = [];
for i=1:length(shat)
    for j = 1:length(shat{i,1})
        result(shat{i,1})=i+n*1000;
    end
end
end

