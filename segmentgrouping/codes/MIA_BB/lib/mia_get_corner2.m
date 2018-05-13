function [cp,idx_res]=mia_get_corner2(curve)
% Copyright (c) 2009, X.C. He All rights reserved.
%   Algorithm is derived from :
%       X.C. He and N.H.C. Yung, ¡°Curvature Scale Space Corner Detector with  
%       Adaptive Threshold and Dynamic Region of Support¡±, Proceedings of the
%       17th International Conference on Pattern Recognition, 2:791-794, August 2004.
    [dp,idx] = linefit_Prasad_RDP_opt(curve);

    cp = [];
    idx_res=[];
    for i=1:length(dp)
        dpp = dp{i}';
        idxp = idx{i};
        [cp{1,i}, idx_res{1,i}] = polygon_extractconnectingpoints_sign(dpp,idxp);
    end
end



function cpm = mia_cpextraction_parsad_sign(imgbw)
    cpm = [];
    boundaries =   bwboundaries(imgbw);
    edgelist=bwboundaries(imgbw);edgelist=edgelist.';
    [dp,idx] = linefit_Prasad_RDP_opt(edgelist);
    for i=1:length(dp)
        dpp = dp{i}';
        cp = polygon_extractconnectingpoints_sign(dpp);
         for ii=1: length(cp)
           cpm = [cpm;cp{ii}(1),cp{ii}(2)];
         end
    end
end
 
function [cp,idx_res] = polygon_extractconnectingpoints_sign(dp, idx)
    nmdp = size(dp,2);
    l = 1;
    cp = {};
    s = zeros(1,nmdp);
    k = 0;
    idx_res=[];
  for j=0:nmdp-1
       pi = dp(:,j+1);
       ind = idx(j+1);
        pa = dp(:,mod(j-l,nmdp)+1);
        pb = dp(:,mod(j+l,nmdp)+1);
        ai = pi - pa;
        ib = pb - pi;
        temp = cross([ai ;0]',[ib ;0]');
        s(j+1) = -sign(temp(3));
      if s(j+1)==1
            k = k + 1;
            cp{k} = pi;
            idx_res(k)=ind;
       end
       
   end
end

function [seglist,idx] = linefit_Prasad_RDP_opt(edgelist)
    N_edge = length(edgelist);
    seglist = {};
    k = 0;
    for e = 1:N_edge
        if length(edgelist{e})< 10
            continue
        end
    %     e
        k = k+1;

        tic;
        y = edgelist{e}(:,1);  
        x = edgelist{e}(:,2);

        first = 1;                
        last = length(x);        
        idx{e} = first;
        No_pts = 1;
        seglist{k}(No_pts,:) = [y(first) x(first)];
        D=[];

        while  first<last
            [max_dev, index, D_temp, precision, reliability,del_tol_max,sum_dev] = maxlinedev_opt(x(first:last),y(first:last)); 

            while max_dev>del_tol_max       % While deviation is > del_tol_max
                last = index+first-1;  % Shorten line to point of max deviation by adjusting last
                [max_dev, index, D_temp, precision, reliability,del_tol_max,sum_dev] = maxlinedev_opt(x(first:last),y(first:last));
            end
           idx{e} = [idx{e},last];
            D(end+1)=D_temp;
            No_pts = No_pts+1;
            seglist{k}(No_pts,:) = [y(last) x(last)];
            first = last;        % reset first and last for next iteration
            last = length(x);
        end

end
end

%% Calculating the actual maximum deviation
function [d_max, index_d_max, S_max, precision, reliability, del_tol_max, sum_dev] = maxlinedev_opt(x,y)
    first=1;
    last=length(x);
    X=[x(first) y(first);x(last) y(last)];
    A=[(y(1)-y(last))/(y(1)*x(last)-y(last)*x(1));(x(1)-x(last))/(x(1)*y(last)-x(last)*y(1))];
    if isnan(A(1))&& isnan(A(2))
    dev=abs(sqrt(sum(([x(first:last) y(first:last)]-repmat([x(first) y(first)],last,1)).^2,2)));
    elseif isinf(A(1)) && isinf(A(2))
     c=x(1)./y(1);
     dev=abs(sum([x(first:last) -c.*y(first:last)]./sqrt(1+c.^2),2));
    else
    dev=abs([x(first:last) y(first:last)]*A-ones(last,1))./sqrt(sum(A.^2));
    end
    [d_max,index_d_max]=max(dev);
    precision=norm(dev)/sqrt(last);
    S_max=max(sqrt(sum(([x(first:last) y(first:last)]-repmat([x(first) y(first)],last,1)).^2,2)));
    reliability=sum(dev)/S_max;
    sum_dev=sum(dev);
    del_phi_max=max(function_digital_case_with_max_error(S_max));
    del_tol_max=tan(del_phi_max).*S_max;
end

%% Calculating the analytical error bound

function [del_phi_tilde_max]=function_digital_case_with_max_error(ss)

    phii=0:pi/360:2*pi;

    [s,phi]=meshgrid(ss,phii);

    term1(:,:,1)=abs(cos(phi));
    term1(:,:,2)=abs(sin(phi));
    term1(:,:,3)=abs(sin(phi)+cos(phi));
    term1(:,:,4)=abs(sin(phi)-cos(phi));

    term1(:,:,5)=abs(cos(phi));
    term1(:,:,6)=abs(sin(phi));
    term1(:,:,7)=abs(sin(phi)+cos(phi));
    term1(:,:,8)=abs(sin(phi)-cos(phi));
    

    tt2(:,:,1)=(sin(phi))./s;
    tt2(:,:,2)=(cos(phi))./s;
    tt2(:,:,3)=(sin(phi)-cos(phi))./s;
    tt2(:,:,4)=(sin(phi)+cos(phi))./s;

    tt2(:,:,5)=-(sin(phi))./s;
    tt2(:,:,6)=-(cos(phi))./s;
    tt2(:,:,7)=-(sin(phi)-cos(phi))./s;
    tt2(:,:,8)=-(sin(phi)+cos(phi))./s;

    term2(:,:,1)=s.*(1-tt2(:,:,1));
    term2(:,:,2)=s.*(1-tt2(:,:,2));
    term2(:,:,3)=s.*(1-tt2(:,:,3));
    term2(:,:,4)=s.*(1-tt2(:,:,4));

    term2(:,:,5)=s.*(1-tt2(:,:,5));
    term2(:,:,6)=s.*(1-tt2(:,:,6));
    term2(:,:,7)=s.*(1-tt2(:,:,7));
    term2(:,:,8)=s.*(1-tt2(:,:,8));

    term2(:,:,1)=s.*(1-tt2(:,:,1)+tt2(:,:,1).^2);
    term2(:,:,2)=s.*(1-tt2(:,:,2)+tt2(:,:,2).^2);
    term2(:,:,3)=s.*(1-tt2(:,:,3)+tt2(:,:,3).^2);
    term2(:,:,4)=s.*(1-tt2(:,:,4)+tt2(:,:,4).^2);

    term2(:,:,5)=s.*(1-tt2(:,:,5)+tt2(:,:,5).^2);
    term2(:,:,6)=s.*(1-tt2(:,:,6)+tt2(:,:,6).^2);
    term2(:,:,7)=s.*(1-tt2(:,:,7)+tt2(:,:,7).^2);
    term2(:,:,8)=s.*(1-tt2(:,:,8)+tt2(:,:,8).^2);

    for s_i=1:length(ss)
        for c_i=1:8
            ss=s(:,s_i);
            t1=term1(:,s_i,c_i);
            t2=term2(:,s_i,c_i);
            case_value(:,c_i)=(1./ss.^2).*t1.*t2;
        end
        del_phi_tilde_max(:,s_i)=max(case_value,[],2);

    end
end