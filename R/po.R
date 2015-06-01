#' Fit PO model
#' 
#' @return parameter estimates of the PO model and its survival curves
#' @export
po = function() {
        t0 = proc.time()
        
        # get pleasant colors
        red = ezplot::palette("red")
        blue = ezplot::palette("blue")
        yellow = ezplot::palette("yellow")
        
        # run po model
        po = nltm::nltm(survival::Surv(TTOBRC, STATUS)~RT, data=dat, 
                        nlt.model="PO")

        # extract beta hats and collect into the correct format for output
        summ = summary(po)
        vars = c("coef", "exp(coef)", "p")
        
        head1 = c("predictor", vars)
        tb1 = c(row.names(summ$coef), round(summ$coef[, vars], 3))
        tb1 = data.frame(rbind(tb1))
        names(tb1) = head1
        row.names(tb1) = NULL
        
        # make output data structure
        tbl_cap = "The parameter estimate of the treatment variable has a p-value greater than 0.05, indicating the effects of radiotherapy are not statistically significant under the PO model."
        tbls = data.frame(tab="PO", name="Model Parameter Estimates",
                          has_caption=TRUE, caption=tbl_cap)
        tbls$header = list(head1)
        tbls$value = list(tb1)

        # calculate survival probabilities for (no radiotherapy) and (radiotherapy)
        po.baselineSF = cumprod(po$surv)
        po.noradioSF = 1/(1-log(po.baselineSF))
        betas = po$coef
        po.radioSF = exp(betas)/(exp(betas)-log(po.baselineSF))
        eventTimes = sort(unique(dat$TTOBRC[dat$STATUS==1]))        
        
        # generate KM plot with survival curves overlayed 
        km = survival::survfit(survival::Surv(TTOBRC, STATUS) ~ RT, data=dat, 
                               type="kaplan-meier")        
        plot(km, lty=c(1, 1), lwd=c(3, 3), col=c(red, blue), ylim=c(0.86, 1), 
             xlab = "Time to breast cancer occurence (in months)", 
             ylab = "Proportion of HD patients without breast cancer",
             main = "KM vs. PO Model Predicted Survival Curves",
             cex.axis = 1.5, cex.lab = 1.5, cex.main=2)
        
        lines(eventTimes,po.noradioSF, type='s', col=yellow, lty=1, lwd=3, 
              ylim=c(0.86,1))
        lines(eventTimes,po.radioSF, type='s', col=yellow, lty=2, lwd=3, 
              ylim=c(0.86,1))
        legend("topright", legend=c("KM: no radiotherapy", "KM: radiotherapy", 
                                    "PO: no radiotherapy", "PO: radiotherapy"),
               lty=c(1, 1, 1, 2), lwd=rep(3, 4), text.font=2, 
               col=c(red, blue, yellow, yellow)) 

        # create data.frame to hold plots title and index
        fig_cap = "This plot of KM vs the predicted survival curves of the PO model shows the PO model fits poorly to the data. It fails to describe the data because it doesn't take into the consideration of the fact that short term and long term effects of a treatment on the hazard can be in opposite directions."
        plts = data.frame(tab="PO", name="", n=1, has_caption=TRUE,
                          caption=fig_cap)
                
        # calculate total time
        dur = proc.time() - t0
        names(dur) = NULL
        runtime = dur[3]
        
        # create data.frame to hold message and run time
        stats = data.frame(tab="PO", msg="success", seconds=runtime)
        
        # collect into out
        out = list(status=stats, tables=tbls, plots=plts, prints=list())
        return(out)        
}