#' Run some descriptive analysis.
#' 
#' @return print out summary stats
#' @export
run_descriptive2 = function() {
        t0 = proc.time()
        
        summ_printout = capture.output(print(summ_stats))
        printout = data.frame(tab="test", stdout=summ_printout)
        
        # calculate total time
        dur = proc.time() - t0
        names(dur) = NULL
        runtime = dur[3]
        
        # create data.frame to hold print outs
        prnts = data.frame(tab="Cox", name="", n=0, has_caption=FALSE,
                           caption=NULL)
        
        # create data.frame to hold message and run time
        stats = data.frame(tab="test", msg="success", seconds=runtime)
        
        # collect into out
        out = list(status=stats, prints=prnts)                
        return(out)
}

# a = capture.output(print(summary(dat)))
# toString(a, width=50)
