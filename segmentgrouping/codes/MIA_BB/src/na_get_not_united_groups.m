function out =na_get_not_united_groups(groups,exclude_segments,segments_points)
    n = size(groups,2);
    out = [];
    for i=1:n
        segs = groups{i}{1,2};
        mask = ismember(segs,exclude_segments);
        not_used_segs = segs(mask);
        if (size(not_used_segs,2)==0)
           continue 
        end
        seg_points = na_get_seg_point(not_used_segs,segments_points);
        cost = na_cmpgroupingcost2(seg_points,intersection);
        out=[out;{cost} {not_used_segs}];
       %TODO: form output
    end

end