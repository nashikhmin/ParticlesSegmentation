function Shat= mia_groupsegments_bb(segin,xcp,ycp,alpha,beta,gamma,I)
% mia_groupsegments performs segment grouping sub-step of the method 
% based on the branch and bound algorithem.

%   Synopsis
%       Shat= mia_groupsegments_bb(segin,xcp,ycp,alpha,beta,gamma,I)
%   Description
%        Segment grouping is done by BB algorithem. BB algorithm 
%        systematically searches all the candidate grouping and
%        attempts to find the optimum.
 
%   Inputs 
%         - I           binary image
%         - segin      cell array contating the contour segments (boundaries and seedpoints) for grouping
%         - xcp         a vector representing x coordinates of concave points
%         - ycp         a vector representing y coordinates of concave points 


%   Outputs
%         - Shat    cell array contating the index of contour segments (optimal solutions)
%                   belong to the same object.

%   Authors
%          Sahar Zafari <sahar.zafari(at)lut(dot)fi>
%
%   Changes
%       14/01/2016  First Edition
% 
%     A=segin';
%     [~,I2] = sort(cellfun(@length,A(:,1)));
%     I2 = flip(I2);
%     segin = A(I2,:)';
    Shat =  []; % optimal solution
    Cp =  [ycp;xcp]; % concave points
    S = [segin{2,:}]; % index of each segments
    
    B = segin(1,:); % segments boundarie
    n = size(B,2);
    for i=1:n
        B{i}(:,3) = i;
    end
    
    nears = na_getNears(B);
    for i=1:size(B,2)
        B{i} = getsegments(B{i});
    end
    intersection = na_getInnerSegmentsList(B);
    intersection = intersection+nears;
    Seed = segin(3,:); % seedpoints
    while ~isempty(S)
            nmS = length(S); % number of contour segmentscc for component ii
            fmin = inf;       % initial value for fmin
%             fprintf('-----------------------------\n');
%             disp(S);
%             fprintf('-----------------------------\n');
            for jj=1:nmS % index for root node - start new branch
                dpc = 0; % depth for root node
                Sjj = S(jj:end);
                P = {Sjj(1),dpc};
                S1 = Sjj;
                sc = P{end,1};
                dpc = P{end,2};
                fsc = na_cmpgroupingcost(B(sc),Seed(sc),Cp,alpha,beta,gamma,I,intersection);
%                 fprintf('%d ',sc);fprintf('| %f\n',fsc);
                if fsc<=fmin
                    if (fsc==0)
                            show_seg(B(sc));
                            close;
                        end
                    fmin = fsc;
                    shatjj = sc;
                    P(end,:) = [];
                else
                    P(end,:) = [];
                end
                T = S1(~ismember(S1,sc));
                if ~isempty(T)
                    P = mia_gencandidatesol(sc, T, P, dpc+1);
                end
                dpcold = dpc;
                iter = 0;
                while (~isempty(P))
                    iter = iter+1;
                    sc = P{end,1};
                    dpc = P{end,2};
                     fsc = na_cmpgroupingcost(B(sc),Seed(sc),Cp,alpha,beta,gamma,I,intersection);
%                     fprintf('%d ',sc);fprintf('| %f\n',fsc);
%                     fprintf('%d  %d\n',fsc,fmin);
%                     pause
                
                    if fsc<fmin
                        if (fsc==0)
                            show_seg(B(sc));
                            close;
                        end
                        fhatjj = fsc;
                        fmin = fsc;
                        shatjj = sc;
                        P(end,:) = [];
                        if dpc~=dpcold
                            T = S1(~ismember(S1,sc));
                        else
                            T = Sjj(~ismember(Sjj,sc));
                        end
                            if ~isempty(T)
                                P = mia_gencandidatesol(sc, T, P, dpc+1);
                            end
                    else
                        S1(S1==P{end}(end)) = [];
                        P(end,:) = [];
                    end
                    dpcold = dpc;
                end    
            end
            Shat = [Shat;{shatjj}];
%             fprintf('.............................\n');
%             disp(shatjj);
%             fprintf('.............................\n');

            S(ismember(S,shatjj)) = [];
    end