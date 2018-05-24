function result = mia_getPointsCW(segments)
%sort segments in clockwise order
%input: unsorted segment
%output: sorted segments
p = [];
for i =1:size(segments,2)
   p = [p;segments{1,i}]; 
end
if (size(segments,2)==1)
   	result = p;
    return
end

collinearCost = 1e-1;
if(collinear(p,collinearCost))
   result = sortrows(p); 
   return;
end


n = length(segments);
res{1,1} = [segments{1,1}];
for i=2:n
    m = size(res,2)+1;
    seg = segments{1,i};
    maxRes = [];
    maxArea = -1;
    for j = 2:m
        newRes1 = [res{1,1:j-1} {seg} res{1,j:end}];
        newRes2 = [res{1,1:j-1} {flipud(seg)} res{1,j:end}];
        
        area1 = mia_getArea(newRes1);
        area2 = mia_getArea(newRes2);
        
        if (area1>maxArea)
            maxRes = newRes1;
            maxArea = area1;
        end
        if (area2>maxArea)
            maxRes = newRes2;
            maxArea = area2;
        end
    end
    res = maxRes;
end

result=[];
for i=1:size(res,2) 
   result = [result; res{1,i}]; 
end