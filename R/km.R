#' Generate Kaplan-Meier Curves
#'
#' @return kaplan-meier plot and a short explanation
#' @export
km = function() {
        t0 = proc.time()
        
        # mk varible to hold display text
        txt = "The Kaplan-Meier curves show that patients who received radiotherapy have a higher proportion of NOT developing breast cancer in the short term than patients who didn't receive radiotherapy, but have a much higher proportion of developing breast cancer in the long term. This leads to a hypothesis: radiotherapy decreases the risk of breast cancer in the short term, but increases its risk in the long term."
        
        # generate KM plot
        km = survival::survfit(survival::Surv(TTOBRC, STATUS) ~ RT, data=dat, 
                               type="kaplan-meier")
        plot(km, lty = c(1:1), col = c("red","blue"), ylim = c(0.86,1), 
             xlab = "Months to breast cancer occurence", 
             ylab = "Proportion of patients with breast cancer development", 
             cex.axis = 1, cex.lab = 1, main = "Kaplan-Meier curves")
        
        # create data.frame to hold plots title and index
        plts = data.frame(tab="Kaplan Meier", title="chart1", n=1, caption=txt)
        
        # calculate total time
        dur = proc.time() - t0
        names(dur) = NULL
        runtime = dur[3]
        
        # create data.frame to hold message and run time
        stats = data.frame(tab="Kaplan Meier", msg="success", 
                           seconds=runtime)
        
        # collect into out
        out = list(plots=plts, status=stats)                
        return(out)
}