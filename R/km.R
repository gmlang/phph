#' Generate Kaplan-Meier Curves
#'
#' @return kaplan-meier plot and a short explanation
#' @export
km = function() {
        t0 = proc.time()
        
        # get pleasant colors
        red = ezplot::cb_color("vermilion")
        blue = ezplot::cb_color("blue")
        
        # generate KM plot
        km = survival::survfit(survival::Surv(TTOBRC, STATUS) ~ RT, data=dat, 
                               type="kaplan-meier")        
        plot(km, lty=c(1, 1), lwd=c(3, 3), col=c(red, blue), ylim=c(0.86, 1), 
             xlab = "Time to breast cancer occurence (in months)", 
             ylab = "Proportion of HD patients without breast cancer", 
             main = "Kaplan-Meier curves", 
             cex.axis = 1.5, cex.lab = 1.5, cex.main=2)
        
        legend("topright", lty=c(1, 1), lwd=c(3, 3), text.font=2,
               legend=c("KM: no radiotherapy", "KM: radiotherapy"), 
               col=c(red, blue))
        
        # create data.frame to hold plots title and index
        txt = "The Kaplan-Meier curves show that patients who received radiotherapy have a higher proportion of NOT developing breast cancer in the short term than patients who didn't receive radiotherapy, but have a much higher proportion of developing breast cancer in the long term. This leads to a hypothesis: radiotherapy decreases the risk of breast cancer in the short term, but increases its risk in the long term."
        plts = data.frame(tab="Kaplan Meier", name="", n=1, has_caption=TRUE,
                          caption=txt)
                        
        # calculate total time
        dur = proc.time() - t0
        names(dur) = NULL
        runtime = dur[3]
        
        # create data.frame to hold message and run time
        stats = data.frame(tab="Kaplan Meier", msg="success", seconds=runtime)
        
        # collect into out
        out = list(status=stats, tables=list(), plots=plts, prints=list())
        return(out)
}