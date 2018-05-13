function near = na_checkNear(p)
near = false;
p = [p;p(1,:)];

bord_p = [];
for i=1:size(p,1)-1
    p1 = p(i,1:2);
    p2 = p(i+1,1:2);
    if p(i,3) ~= p(i+1,3) 
       bord_p = [bord_p; p(i,:);p(i+1,:)];
    end
end

bord_p = sortrows(bord_p);

for i=1:size(bord_p,1)-1
    p1 = bord_p(i,1:2);
    p2 = bord_p(i+1,1:2);
    if bord_p(i,3) ~= bord_p(i+1,3) && norm(p1-p2)<4
      near = true;
    end
end

end

