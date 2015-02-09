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
        
        # create data.frame to hold message and run time
        stats = data.frame(tab="test", msg="success", 
                           seconds=runtime, has_stdout=TRUE)
        
        # collect into out
        out = list(status=stats, stdout=printout)                
        return(out)
}


