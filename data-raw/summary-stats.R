proj_path = file.path(Sys.getenv("HOME"), "openCPU/apps")
setwd(file.path(proj_path, "phph"))
load("data/dat.rda")

# split data
radio = subset(dat, RT=="Radiotherapy") 
noradio = subset(dat, RT=="No radiotherapy")

# get summary stats
dat$STATUS = as.factor(ifelse(dat$STATUS==1, "breast cancer", 
                              "no breast cancer"))
summ_convars = list()
summ_catvars = list()
for (j in 1:ncol(dat)) {
        head = names(dat)[j]
        v = dat[[j]]
        summ = summary(v)
        name = names(summ)
        if (class(v) %in% c("integer", "numeric")) {
                summ = as.numeric(summ)
                df = data.frame(name, summ)
                names(df) = c("name", head)
                summ_convars[[head]] = df
        }
                
        if (class(v) %in% c("character", "factor")) {
                summ = as.integer(summ)
                df = data.frame(name, summ)
                names(df) = c("name", head)
                summ_catvars[[head]] = df
        }
                
}

summ_stats = summary(dat)
summ_printout = capture.output(print(summ_stats))
summ_printout = paste(summ_printout, collapse="\n")

devtools::use_data(summ_convars, summ_catvars, summ_printout, 
                   radio, noradio, internal=TRUE, overwrite=TRUE)
