function segment = mia_segmentcurve(bnd,idx)
% mia_segmentcurve split the boundaries into contour segments.

%   Synopsis
%       segments = mia_segmentcurve(bnd,idx)
%   Description
%        Returns the contour segments.The obtained concave points
%        are used to split the contours into contour segments.
%        
%   Inputs 
%         - bnd     cell array contating the coordiantes of curve in the
%                   image, Matrix n-by-2 representing coordiantes of curve.
%         - idx     cell array containin the index of detected concavepoints. 

%       
%        
%   Outputs
%        - segments    cell array contating the contour segments
%                           
%   Authors
%          Sahar Zafari <sahar.zafari(at)lut(dot)fi>
%
%   Changes
%       14/11/2016  First Edition
%----------------------------------------------------------------------------------------
    segment = cell(1,size(idx,2));
    
    nidx = [];
    nbnd = [];
    for i=1:size(idx,2)
        if (~isempty(idx{1,i}))
            nidx = [nidx {idx{1,i}}];
            nbnd = [nbnd {bnd{1,i}}];
        end
    end
    bnd = nbnd;
    idx = nidx;
    for j=1:size(idx,2) % iterate+over connected components
        seg =cell(1,length(idx{1,j}));
        numpts = length(bnd{j});
        
        if (idx{1,j}) == 0 % curve without extermum 
             seg{1,1} = bnd{j};
             segment{1,j} = seg;
            continue;
        end
        numconcpts = length(idx{1,j});
        idxst = idx{1,j};
        idxsttemp = idxst;
        idxed =  idxsttemp([ 2:end 1 ]);
        for ii=1:numconcpts
            if idxed(ii)>idxst(ii)
                seg{1,ii}= bnd{j}(idxst(ii):idxed(ii),:);
            else
               segs = bnd{j}(idxst(ii):numpts,:);
               segp= bnd{j}(1:idxed(ii),:);
               seg{1,ii} = [segs;segp];
             end
        end
        seg = reshape(seg(~cellfun(@isempty,seg)),1,[]);
        segment{1,j} = seg;
    end
