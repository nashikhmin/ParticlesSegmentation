function mia_viscp(segin,xc,yc)
  for l = 1:length(segin)
      col_seg = linspecer(length(segin{l}));
     for i=1:size(segin{l},2)
        scatter(segin{l}{1,i}(:,2),segin{l}{1,i}(:,1),[],'MarkerEdgeColor',col_seg(i,:,:),'MarkerFaceColor',col_seg(i,:,:)); hold on
        scatter(segin{l}{3,i}(:,2),segin{l}{3,i}(:,1),[],'s','MarkerEdgeColor',col_seg(i,:,:),'MarkerFaceColor',col_seg(i,:,:)); hold on
     end
      plot(yc{l},xc{l},'ob','markerfacecolor','g'); hold on
  end
end

