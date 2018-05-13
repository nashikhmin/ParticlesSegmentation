% cfg.imsize
% cfg.nobjects
% cfg.maxoverlap
% cfg.objectfunc
% cfg.objectcfg
function [img, gtimg, gtparam] = gen_img(cfg)

img = logical(zeros(cfg.imsize));
gtimg = cell(cfg.imsize);

for i = 1:cfg.nobjects
  done = 0; counter = 0;
  while ~done;
    [objectimg, boundaries] = feval(cfg.objectfunc, cfg.imsize, cfg.objectcfg);
  
    overlapimg = img & objectimg;
  
    if sum(overlapimg(:))/sum(objectimg(:)) <= cfg.maxoverlap;
      done = 1;
    end;

    counter = counter + 1;
    if counter > 1000
      error('Program failed to draw the desired number of objects. Please, reduce the number or size of objects or increase the image size or maximum overlap');
      return;
    end;
  end;

  img = img + objectimg;

  for j = find(objectimg)'
    try
      gtimg{j} = [gtimg{j},i];
    catch
      keyboard;
    end;
  end;
  
  gtparam{i} = boundaries;
end;

img = ~img;