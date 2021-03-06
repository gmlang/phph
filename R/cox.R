#' Fit Cox PH model
#' 
#' @return parameter estimates of the Cox model and its survival curves
#' @export
cox = function() {
        t0 = proc.time()
        
        # get pleasant colors
        red = ezplot::cb_color("vermilion")
        blue = ezplot::cb_color("blue")
        green = ezplot::cb_color("bluish_green")
        
        # run cox model
        cox = survival::coxph(survival::Surv(TTOBRC, STATUS) ~ RT,  
                              data=dat, method="breslow")
        
        # extract beta hats and collect into the correct format for output
        summ_cox = summary(cox)
        vars = c("coef", "exp(coef)", "Pr(>|z|)")
        
        head1 = c("predictor", vars)
        tb1 = c(row.names(summ_cox$coef), round(summ_cox$coef[, vars], 3))
        tb1 = data.frame(rbind(tb1))
        names(tb1) = head1
        row.names(tb1) = NULL
                
        # make output data structure
        tbl_cap = "The parameter estimate of the treatment variable has a p-value greater than 0.05, indicating the effects of radiotherapy are not statistically significant under the Cox model."
        tbls = data.frame(tab="Cox", name="Model Parameter Estimates", 
                          has_caption=TRUE, caption=tbl_cap)
        tbls$header = list(head1)
        tbls$value = list(tb1)
        
        # calculate predicted survival rates
        survcurve.cox.notreat = survival::survexp(~RT, data=radio, 
                                                  ratetable=cox, cohort=TRUE)
        survcurve.cox.treat = survival::survexp(~RT, data=noradio, 
                                                ratetable=cox,  cohort=TRUE)
        
        # generate KM plot with survival curves overlayed 
        km = survival::survfit(survival::Surv(TTOBRC, STATUS) ~ RT, data=dat, 
                               type="kaplan-meier")
        plot(km, lty=c(1, 1), lwd=c(3, 3), col=c(red, blue), ylim=c(0.86, 1), 
             xlab = "Time to breast cancer occurence (in months)", 
             ylab = "Proportion of HD patients without breast cancer", 
             main = "KM vs. Cox Model Predicted Survival Curves",
             cex.axis = 1.5, cex.lab = 1.5, cex.main=2)
        
        lines(survcurve.cox.notreat, col=green, ylim=c(0.86,1), 
              lty=1, lwd=3)
        lines(survcurve.cox.treat, col=green, ylim=c(0.86,1), 
              lty=2, lwd=3)
        legend("topright", lty=c(1,1,1,2), lwd=rep(3, 4), text.font=2,
               legend=c("KM: no radiotherapy", "KM: radiotherapy", 
                        "Cox: no radiotherapy", "Cox: radiotherapy"), 
               col=c(red, blue, green, green))
        
        # create data.frame to hold plots title and index
        fig_cap = "This plot of KM vs the predicted survival curves of the Cox model shows the Cox model fits poorly to the data. It fails to describe the data because it doesn't take into the consideration of the fact that short term and long term effects of a treatment on the hazard can be in opposite directions."
        plts = data.frame(tab="Cox", name="", n=1, has_caption=TRUE,
                          caption=fig_cap)
                
        # calculate total time
        dur = proc.time() - t0
        names(dur) = NULL
        runtime = dur[3]
        
        # create data.frame to hold message and run time
        stats = data.frame(tab="Cox", msg="success", seconds=runtime)
        
        # collect into out
        out = list(status=stats, tables=tbls, plots=plts, prints=list())
        return(out)        
}