#' Fit PHPH cure model
#' 
#' @return parameter estimates of the PHPH cure model and its survival curves
#' @export
phph = function() {
        t0 = proc.time()
        
        red = ezplot::palette("red")
        blue = ezplot::palette("blue")
        purple = ezplot::palette("purple")
        
        # run phph model
        phph = nltm::nltm(survival::Surv(TTOBRC, STATUS)~RT, data=dat, nlt.model="PHPHC")
        
        # extract beta hats and collect into the correct format for output
        summ = summary(phph)
        vars = c("coef", "exp(coef)", "p")
        
        head1 = c("predictor", vars)
        row1 = c(row.names(summ$coef)[1], round(summ$coef[1, vars], 3))
        row2 = c(row.names(summ$coef)[2], round(summ$coef[2, vars], 3))
        row3 = c(row.names(summ$coef)[3], round(summ$coef[3, vars], 3))
        tb1 = data.frame(rbind(row1, row2, row3))
        names(tb1) = head1
        row.names(tb1) = NULL
        
        # make output data structure
        tbl_cap = "The p-values are all exceedingly small, indicating the beta estimates are all statistically significant. In particular, the significant beta estimate for radiotherapy in the short term predictor implies radiotherapy has a negative short term effect; the significant beta estimate for radiotherapy in the long term predictor implies radiotherapy has a positive effect on the breast cancer occurrence rates in the long term."
        tbls = data.frame(tab="phph", name="Model Parameter Estimates",
                          has_caption=TRUE, caption=tbl_cap)
        tbls$header = list(head1)
        tbls$value = list(tb1)
        
        # calculate survival probabilities for (no radiotherapy) and (radiotherapy)
        CureRate = phph$coeff[length(phph$coeff)]
        betas = phph$coeff
        # long-term predictor for subjects with radiotherapy treatment
        betasCure = betas[1:phph$nvar$pred.long]
        logtheta = CureRate + betasCure
        theta = exp(logtheta)
        # Short-term predictor for subjects with radiotherapy treatment
        betasNonCured = betas[phph$nvar$pred.long + 1:phph$nvar$pred.short]
        logeta = betasNonCured
        eta = exp(logeta)
        # unique event times sorted
        eventTimes = sort(unique(dat$TTOBRC[dat$STATUS==1]))
        # baseline survival function values corresponding to eventTimes
        phph.baselineSF = cumprod(phph$surv)
        # Survival function for subjects with radiotherapy
        phph.radioSF = exp(-theta*(1-phph.baselineSF^eta))
        # Survival function for subjects without radiotherapy
        phph.noradioSF = exp(-exp(CureRate)*(1-phph.baselineSF))
        
        # generate KM plot with survival curves overlayed 
        km = survival::survfit(survival::Surv(TTOBRC, STATUS) ~ RT, data=dat, 
                               type="kaplan-meier")        
        plot(km, lty=c(1, 1), lwd=c(3,3), col=c(red, blue), ylim=c(0.86, 1), 
             xlab = "Time to breast cancer occurence (in months)", 
             ylab = "Proportion of HD patients without breast cancer",
             main = "KM vs. PHPH Cure Model Predicted Survival Curves",
             cex.axis = 1.5, cex.lab = 1.5, cex.main=2)
        
        lines(eventTimes, phph.noradioSF, type='s', lty=1, lwd=3, 
              ylim=c(0.86,1), col=purple)
        lines(eventTimes ,phph.radioSF, type='s', lty=2, lwd=3, 
              ylim=c(0.86,1), col=purple)
        legend("topright", legend=c("KM: no radiotherapy", "KM: radiotherapy", 
                                    "PHPH: no radiotherapy", "PHPH: radiotherapy"),
               lty=c(1,1,1,2), lwd=rep(3,4), text.font=2, 
               col=c(red, blue, purple, purple))         
        
        # create data.frame to hold plots title and index
        fig_cap = "We plot the observed KM curves against the predicted survival curves under the PHPHC model, and it shows the PHPHC model fits the data well. This is because the phph cure model includes a term that captures the short term effect explicitly."
        plts = data.frame(tab="phph", name="", n=1, has_caption=TRUE,
                          caption=fig_cap)
        
        # calculate total time
        dur = proc.time() - t0
        names(dur) = NULL
        runtime = dur[3]
        
        # create data.frame to hold message and run time
        stats = data.frame(tab="phph", msg="success", seconds=runtime)
        
        # collect into out
        out = list(status=stats, tables=tbls, plots=plts, prints=list())
        return(out)        
}