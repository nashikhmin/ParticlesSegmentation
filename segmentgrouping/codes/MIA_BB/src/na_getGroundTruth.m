function poly_seg_groups = na_getGroundTruth(gt_path, segments)
%NA_GETGROUNDTRUTH Summary of this function goes here
%   Detailed explanation goes here
groundData = load(gt_path);
groundData = groundData.gtparam;


polys = [];
poly_seg_groups=[];
for i=1:length(groundData)
   points = groundData{1,i};
   if (isempty(points))
       continue;
   end
   poly = polyshape(points(:,1),points(:,2),'Simplify',true);
   [cx,cy] = centroid(poly);
    if isnan(cx)
      cx = mean(points(:,1));
    end
    if (isnan(cy))
      cy = mean(points(:,2));
    end
    poly = scale(poly,1.15,[cx cy]);
    polys{i} =poly;
    poly_seg_groups{i}=[];

end


used=zeros([1 length(segments)]);


for i=1:size(segments,2)
   seg = segments{1,i};

   p_ind=-1;
   p_count = 0;
   for j = 1:length(polys)
       poly = polys{1,j};
        if (isempty(poly))
            continue;
        end
       count = sum(isinterior(poly,seg(:,1),seg(:,2)));
       if (count>p_count)
          p_ind = j;
          p_count = count;
       end
   end
   if (p_count>0)
      poly_seg_groups{p_ind} = [poly_seg_groups{p_ind} i]; 
      used(i)=1;
   end
       
end

poly_seg_groups = poly_seg_groups(~cellfun('isempty',poly_seg_groups));  

for i=1:size(segments,2)
    if (~used(i))
        poly_seg_groups = [poly_seg_groups {i}];
    end

end