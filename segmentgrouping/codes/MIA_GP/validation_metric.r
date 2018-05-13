evaluating_criteria <- function(img_name) {
  filename <- paste("/home/nashikhmin/git/masterThesis/comphi1/segmentgrouping/codes/MIA_BB/result/",img_name,sep="")
  filename_gt = paste(filename, "gt", sep="-")
  filename_pred = paste(filename, "pred", sep="-")
  gt <-  as.integer(scan(filename_gt, what="", sep=","))
  pred <-  as.integer(scan(filename_pred, what="", sep=","))
  res <- as.double(mclustcomp::mclustcomp(gt,pred,,types="mmm")[1,2]) 
}
