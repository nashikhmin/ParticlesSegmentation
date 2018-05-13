function result = na_get_seg_point(seg_indexes,segments)
result = [];
for i=1:size(seg_indexes,2)
   result = [result {segments{seg_indexes(i)}}];
end
end

