function J = na_cmpgroupingcost(segin, intersec)
% mia_cmpgroupingcost compute the grouping cost J.

%   Synopsis
%        J = mia_cmpgroupingcost(segin,seeds,cp,I)
%   Description
%              grouping cost is a hybrid cost function consisting of
%              two parts: 1) generic part (Jcon) that encapsulate the
%              general convexity properties of the objects and 2) specific
%              part that encapsulates the properties of objects symmetry
%              (Jsymm) and ellipticity (Jelp).

%   Inputs
% - segin      a cell array containing the contour segments
% - seeds      a cell array containing the seedpoints
% - aplha      weighing parameter for concavity
% - beta       weighing parameter for elipcity
% - gamma      weighing parameter for symmetry
% - cp         a cell array containing the concave points
% - I          binary image


%   Outputs
% J        cost value
%
%   Authors
%          Sahar Zafari <sahar.zafari(at)lut(dot)fi>
%
%   Changes
%       14/11/2016  First Edition
%----------------------------------------------------------------------------------------
%Jcon = mia_concavity(segin,I); % concavity cost
%xyst = [];


if (length(segin)==1)
    J = 1;
    return
end

segments=[];
for i=1:length(segin)
    segments{i} = segin{i};
end

p = na_getPointsCW(segments);

A = polyarea(p(:,1),p(:,2));
if (A<=1)
    J=1/length(segments);
    return
end


J = 0;
x = p(:,1);
y = p(:,2);

indexes = [];
for i=1:size(segin,2)
    indexes(i) = segin{1,i}(1,3);
end

ss = 0;
for i=1:length(indexes)
    for j=i+1:length(indexes)
        ss = ss + intersec(indexes(i),indexes(j));
    end
end
if (ss>0)
    J=inf;
    return
end

k = convhull(x,y);
B = polyarea(x(k),y(k));

len = sqrt((p(1,1)-p(end,1))^2+(p(1,2)-p(end,2))^2);

if ((abs(A-B)/A>0.059 && len*2<B))
    J=inf;
    return
end

[~,~,area_rec] = minboundparallelogram(p(:,1),p(:,2));

[trix,triy] = minboundtri(p(:,1),p(:,2));
area_tri = polyarea(trix,triy);

[AA,c] = minboundellipse(p(:,1:2)',.01);
xx = Ellipse_plot(AA,c);
area_ellipse = polyarea(xx(1,:),xx(2,:));

J = (J+min([area_tri,area_rec,area_ellipse])/A)/(length(segments));
end

