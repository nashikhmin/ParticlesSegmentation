function result = na_check_grouping(segments,intersec)
 indexes = [];
for i=1:size(segments,2)
    indexes(i) = segments{1,i}(1,3);
end


ss = 0;
for i=1:length(segments)
    for j=i+1:length(segments)
        ss = ss + intersec(indexes(i),indexes(j));
    end
end
result = true;
if (ss>0)
   result=false; 
end
end

