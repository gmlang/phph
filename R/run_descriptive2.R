#' Run some descriptive analysis.
#' 
#' @return print out summary stats
#' @export
run_descriptive2 = function() {
        t0 = proc.time()
        
        # create data.frame to hold print outs
        prnts = data.frame(tab="test", name="summary of the variables",
                           has_caption=FALSE, caption="", 
                           stdout=summ_printout)
                        
        # calculate total time
        dur = proc.time() - t0
        names(dur) = NULL
        runtime = dur[3]
                
        # create data.frame to hold message and run time
        stats = data.frame(tab="test", msg="success", seconds=runtime)
        
        # collect into out
        out = list(status=stats, tables=list(), plots=list(), prints=prnts)
        return(out)
}