function J = na_cmpgroupingcost2(segments,intersec)
    sq_sum = 0;
    for i=1:length(size(segments,2))
        sq_sum = sq_sum + polyarea(segments{i}(:,1),segments{i}(:,2));
    end
    
    p = na_getPointsCW(segments);
    A = polyarea(p(:,1),p(:,2));
    J = 0;
    
    x = p(:,1);
    y = p(:,2);
    
    indd = unique(p(:,3))';
    
    if (na_check_grouping(segments,intersec))
        J=inf; 
        return;
    end
    if (A>1) 
        k = convhull(x,y);
        B = polyarea(x(k),y(k));

        len = sqrt((p(1,1)-p(end,1))^2+(p(1,2)-p(end,2))^2);
        
      
        if (abs(A-B)/A>0.055 && len*2<B)
%              if (sum(ismember([5 7 9 11], indd))>=2)
%                 show_seg(segments);
%                 close;
%                 z=0;
%              end
            J=inf;  
            return;
        end     
    end
    J = (J+1)/size(segments,2);
end

