function mia_visevidecnes(segments)
    col_seg = linspecer(length(segments)) ;
    for i=1:length(segments)
       scatter(segments{i}(:,2),segments{i}(:,1),[],'MarkerEdgeColor',col_seg(i,:,:),'MarkerFaceColor',col_seg(i,:,:))
    end
end

