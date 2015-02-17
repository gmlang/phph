#' Run some descriptive analysis.
#' 
#' @return print out summary stats
#' @export
run_descriptive2 = function() {
        t0 = proc.time()
        
        # create data.frame to hold print outs
        head1 = c("variable", names(summ_convars))
        tb1 = cbind(summ_convars[[1]], summ_convars[[2]][,2])
        names(tb1) = c("variable", "TTOBRC", "AGE")
        row.names(tb1) = NULL
        
        head2 = c("variable", names(summ_catvars)[1])
        tb2 = summ_catvars[[1]]
        names(tb2) = c("variable", "STATUS")
        
        head3 = c("variable", names(summ_catvars)[2])
        tb3 = summ_catvars[[2]]
        names(tb3) = c("variable", "RT")
        
        # make output data structure
        tbls = data.frame(tab = "Descriptive Analysis", name = c("", "", ""),
                          has_caption = c(F, F, F), caption = c("", "", ""))
        tbls$header = list(head1, head2, head3)
        tbls$value = list(tb1, tb2, tb3)
        
        # calculate total time
        dur = proc.time() - t0
        names(dur) = NULL
        runtime = dur[3]
                
        # create data.frame to hold message and run time
        stats = data.frame(tab="test", msg="success", seconds=runtime)
        
        # collect into out
        out = list(status=stats, tables=tbls, plots=list(), prints=list())
        return(out)
}