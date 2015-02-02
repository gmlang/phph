#' Run some descriptive analysis.
#' 
#' @return summary stats and a boxplot
#' @export
run_descriptive = function() {    
        t0 = proc.time()
        
        head1 = c("rowname", names(summ_convars))
        tb1 = cbind(summ_convars[[1]], summ_convars[[2]][,2])
        names(tb1) = c("rowname", "TTOBRC", "AGE")
        row.names(tb1) = NULL
        
        head2 = c("rowname", names(summ_catvars)[1])
        tb2 = summ_catvars[[1]]
        names(tb2) = c("rowname", "STATUS")
        
        head3 = c("rowname", names(summ_catvars)[2])
        tb3 = summ_catvars[[2]]
        names(tb3) = c("rowname", "RT")
        
        # make output data structure
        tbls = data.frame(tab = "Summary Statistics", name = c("", "", ""))
        tbls$header = list(head1, head2, head3)
        tbls$value = list(tb1, tb2, tb3)
        
        # make boxplot
        f = mk_box_plt(dat)
        p = f("RT", "TTOBRC", ylab_str="Time to Breast Cancer Occurrence")
        print(p)
        
        # create data.frame to hold plots title and index
        plts = data.frame(tab="Summary Statistics", title="chart1", n=1)
        
        # calculate total time
        dur = proc.time() - t0
        names(dur) = NULL
        runtime = dur[3]
        
        # create data.frame to hold message and run time
        stats = data.frame(tab="Summary Statistics", msg="success", 
                           seconds=runtime)
                
        # collect into out
        out = list(tables=tbls, plots=plts, status=stats)                
        return(out)        
}