function out = na_segmentgrouping_rec(groups,segments,intersection_table)
    new_groups = [];
    n = size(groups,2);
    for i=1:n
       for j=i+1:n
          group_i = groups{i,2};
          group_j = groups{j,2};
          cost_i = groups{i,1};
          cost_j = groups{j,1};
          [cost, united_groups] = na_unite_segments(group_i,group_j,segments,intersection_table);
          if (cost < min(cost_i, cost_j)) 
            new_groups=[new_groups;{cost} {united_groups}];
          end
       end
    end
    new_segments = na_getSegmentsFromGroups(new_groups);
    out = na_get_not_united_groups(groups,new_segments,segments);
    out = [out;na_segmentgrouping_rec(new_groups,segments,intersection_table)];
end
