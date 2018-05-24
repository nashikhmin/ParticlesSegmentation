function [matrix] = mia_getNears(B)
    n = size(B,2);

    Points = [];
    for i=1:n
       Points = [Points;B{i}];
    end
    
    matrix = zeros(n,n);
    for i=1:n
        for j=i+1:n
            
            segs{1} = B{i};
            segs{2} = B{j};
            segPoints = mia_getPointsCW(segs);
            if (mia_checkNear(segPoints))
                matrix(i,j)=1;
                matrix(j,i)=1;
            end
       end
    end   
    
    