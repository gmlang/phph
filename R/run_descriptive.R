#' Run some descriptive analysis.
#' 
#' @return summary stats and a boxplot
#' @export
run_descriptive = function() {    
        t0 = proc.time()
        
        # create data.frame to hold print outs
        prnts = data.frame(tab="Descriptive Analysis", name="Summary of the Variables",
                           has_caption=FALSE, caption="", stdout=summ_printout)
        
        # make boxplot
        plt = ezplot::mk_boxplot(dat)
        p = plt("RT", "TTOBRC", 
#                 main = "Distribution of time (in months) to breast cancer occurrence",
                ylab = "Time to Breast Cancer Occurrence (in Months)", 
                legend=F)
        p = ezplot::web_display(p)
        print(p)
        
        # create data.frame to hold plots title and index
        plts = data.frame(tab="Descriptive Analysis", name="", n=1, 
                          has_caption=FALSE, caption="")
                
        # calculate total time
        dur = proc.time() - t0
        names(dur) = NULL
        runtime = dur[3]
        
        # create data.frame to hold message and run time
        stats = data.frame(tab="Descriptive Analysis", msg="success", 
                           seconds=runtime)
                
        # collect into out
        out = list(status=stats, tables=list(), plots=plts, prints=prnts)
        return(out)        
}
