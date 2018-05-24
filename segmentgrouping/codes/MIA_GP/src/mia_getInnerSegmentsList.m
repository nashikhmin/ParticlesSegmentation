function [matrix] = mia_getInnerSegmentsList(B)
%get matrix of intersections, if 1 the the segments canoot be in one group


n = size(B,2);
Points = [];
for i=1:n
    segment = B{i}(1:10:end,:);
    Points = [Points;segment];
end


matrix = zeros(n,n);
for i=1:n
    for j=i+1:n
        segs = [];
        segs{1} = B{i};
        segs{2} = B{j};
        segPoints = mia_getPointsCW(segs);
        aa = polyshape(segPoints(:,1),segPoints(:,2),'Simplify',true);
        [cx,cy] = centroid(aa);
        if (cx>1e5)
            cx = mean(segPoints(:,1));
        end
        if (cy>1e5)
            cy = mean(segPoints(:,2));
        end
        bb = scale(aa,0.9,[cx cy]);
        [in,on] = isinterior(bb,Points(:,1),Points(:,2));
        in = in(~on);
        inner = unique(Points(in,3));
        numbers = histc(Points(in,3),inner);
        inter = [inner numbers];
        inter = inter(inter(:,1)~=i,:);
        inter = inter(inter(:,1)~=j,:);
        result = sum(inter(:,2)>1);

        if ( sum(inter(:,2)>1)>0)
            matrix(i,j)=1;
            matrix(j,i)=1;
        end
    end
end
end

