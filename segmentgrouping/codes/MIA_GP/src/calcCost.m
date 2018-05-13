function result = calcCost(p)
emptySpace = 0;
filledSpace = 0;
n = size(p,1);
p = [p; p(1,:)];
for i=1:n
    p1 = p(i,1:2);
    p2 = p(i+1,1:2);
    d = norm(p1-p2);
    if (p(i,3) ~= p(i+1,3))
       emptySpace = emptySpace + d;
    else
       filledSpace = filledSpace+d;
    end
end
rel = emptySpace/(filledSpace+emptySpace);

result = 1 - rel;
end
