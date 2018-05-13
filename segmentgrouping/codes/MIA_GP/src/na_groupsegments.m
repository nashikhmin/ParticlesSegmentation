function Shat= na_groupsegments(segin)
    Shat =  []; % optimal solution

    segments = segin(1,:); % segments boundaries
    n = size(segments,2);
    for i=1:n
        segments{i}(:,3) = i;
    end
    
    for i=1:size(segments,2)
        segments{i} = getsegments(segments{i});
    end
    intersection = na_getInnerSegmentsList(segments);
    
    
    groups = [];
    for i=1:length(size(segments,2))
        cost = na_cmpgroupingcost2({segments{1,i}}, intersection);
        groups = [groups; {cost} {i}];
    end
    out = na_segmentgrouping_rec(groups,segments,intersection_table)
    Shat = out;
end
