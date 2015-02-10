#' Run some descriptive analysis.
#' 
#' @return print out summary stats
#' @export
run_descriptive2 = function() {
        t0 = proc.time()
        
        summ_printout = capture.output(print(summ_stats))
        summ_printout = paste(summ_printout, collapse="\n")
        
        # create data.frame to hold print outs
        prnts = data.frame(tab="test", name="summary of the variables",
                           n=1, has_caption=FALSE)
        prnts$stdout = list(summ_printout)
        prnts$caption = list(NULL)
        
        # create data.frame to hold tables
        tbls = data.frame(tab="test", name="", n=0, has_caption=FALSE)
        tbls$header = list(NULL)
        tbls$value = list(NULL)
        tbls$caption = list(NULL)
        
        # create data.frame to hold plots title and index
        plts = data.frame(tab="test", name="", n=0, has_caption=FALSE)
        plts$caption = list(NULL)
        
        # calculate total time
        dur = proc.time() - t0
        names(dur) = NULL
        runtime = dur[3]
                
        # create data.frame to hold message and run time
        stats = data.frame(tab="test", msg="success", seconds=runtime)
        
        # collect into out
        out = list(status=stats, tables=tbls, plots=plts, prints=prnts)
        return(out)
}