function [outputArg1,outputArg2] = na_groupall(inputArg1,inputArg2)

    Shat =  []; % optimal solution
    Cp =  [ycp;xcp]; % concave points
    S = [segin{2,:}]; % index of each segments
    B = segin(1,:); % segments boundaries
    n = size(B,2);
    for i=1:n
        B{i}(:,3) = i;
    end
    graph = na_getInnerSegmentsList(B);
    Seed = segin(3,:); % seedpoints
    OutGroups = []
    OutGroupsCost = [];
    
    currentGroups = S;
    
    while ~isempty(currentGroups)
            m = length(currentGroups);
            newGroups = [];
            for j=1:m 
                group = currentGroups{1,j}
                cand = [];
                for i=1:n
                    seg = S{1,i};
                    if (canAddSegmentToGroup(seg,group,graph)
                       newGroups = [newGroups [group seg]]; 
                    end
                end
            end
            
    end
end

