function [idxcp,xcp,ycp, bnd] = mia_concvptobnd(bnd,xc,yc,concp)
% assigns each detected concave point on the curve to boundaries
    xcp =[]; ycp = [];
% assign each cc point to bnd
    nmcbnd = size(bnd,2);
    for ii = 1:nmcbnd
        bndii = bnd{ii};
        temp=[];
        idxcp{ii} = 0;
        nmconcpts = length(xc);
        for  jj=1:nmconcpts
            val =10;   
            cpjj = [yc(jj),xc(jj)];
            [valm,idxm] = min(pdist2(bndii,cpjj));
            if valm < val
                val = valm;
                temp = [idxm,temp];
                temp = sort(temp);
                idxcp{ii} = temp;
                ycp(jj) = bndii(idxm,2);
                xcp(jj) = bndii(idxm,1);
            end
       end   
    end    
    idxcp =  idxcp(~cellfun('isempty', concp)) ;
    bnd = bnd(~cellfun('isempty',concp)) ;
end


