function [angles] = angles(p)
n = size(p,1);
p = [p;p(1,:);p(2,:)];
flipud(p);
angles = [];
for i=2:n+1
    P0 = p(i,1:2)';
    P1 = p(i-1,1:2)';
    P2 = p(i+1,1:2)';
    n1 = (P2 - P0) / norm(P2 - P0);  % Normalized vectors
    n2 = (P1 - P0) / norm(P1 - P0);
    x1 = n1(1);
    y1 = n1(2);
    x2= n2(1);
    y2 = n2(2);
    ang = atan2d(x1*y2-y1*x2,x1*x2+y1*y2);
    angles = [angles ang];
    
end
end

