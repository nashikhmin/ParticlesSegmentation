function simg = gt_segment(gtimg, k)

simg = logical(zeros(size(gtimg)));
for i = 1:size(gtimg,1)
  for j = 1:size(gtimg,2)
    if sum(gtimg{i,j}==k)
      simg(i,j) = 1;
    end;
  end;
end;
