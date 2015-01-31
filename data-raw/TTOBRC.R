dat = read.table("data-raw/TTOBRC.txt", header=TRUE)
dat$RT = factor(dat$RT, labels = c("Radiotherapy", "No radiotherapy")) 
devtools::use_data(dat, overwrite=TRUE)