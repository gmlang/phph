proj_path = file.path(Sys.getenv("HOME"), "openCPU/apps")
setwd(file.path(proj_path, "phph"))

load("data/dat.rda")

radio = subset(dat, RT=="Radiotherapy") 
noradio = subset(dat, RT=="No radiotherapy")

devtools::use_data(radio, noradio, internal=TRUE, overwrite=TRUE)

