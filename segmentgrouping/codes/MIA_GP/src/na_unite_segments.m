function [cost, united_groups] = na_unite_segments(a,b,segments,intersection)
    all_points = unique([a b]);
    united_groups = na_get_seg_point(all_points,segments);
    cost = na_cmpgroupingcost2(united_groups,intersection);
end

