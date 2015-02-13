#' Fit PHPH cure model
#' 
#' @return parameter estimates of the PHPH cure model and its survival curves
#' @exphphrt
phph = function() {
        t0 = proc.time()
        
        # run phph model
        phph = nltm::nltm(survival::Surv(TTOBRC, STATUS)~RT, data=dat, nlt.model="PHPHC")
        
        # extract beta hats and collect into the correct format for output
        summ = summary(phph)
        vars = c("coef", "exp(coef)", "p")
        
        head1 = c("rowname", vars)
        tb1 = c(row.names(summ$coef), round(summ$coef[, vars], 3))
        row.names(tb1) = NULL
        
        # make output data structure
        tbl_cap = "The parameter estimate of the treatment variable has a p-value less than 0.05, indicating the effects of radiotherapy are statistically significant under the phph cure model."
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
        plot(km, lty = c(1:1), col = c("red","blue"), ylim = c(0.86,1), 
             xlab = "Months to breast cancer occurence", 
             ylab = "Prophphrtion of patients with breast cancer development", 
             cex.axis = 1, cex.lab = 1, main = "KM vs. phph Model Predicted Survival Curves")
        
        lines(eventTimes, phph.noradioSF, type='s', lty=1, lwd=3, ylim=c(0.86,1))
        lines(eventTimes ,phph.radioSF, type='s', lty=2, lwd=3, ylim=c(0.86,1))
        legend("topright", legend=c("KM: no radiotherapy", "KM: radiotherapy", 
                                    "PHPH: no radiotherapy", "PHPH: radiotherapy"),
               lty=c(1,1,1,2), col=c("red","blue","black","black"))         
        
        # create data.frame to hold plots title and index
        fig_cap = "This plot of KM vs the predicted survival curves of the phph cure model shows the phph cure model fits very well to the data."
        plts = data.frame(tab="phph", name="", n=1, has_caption=TRUE,
                          caption=fig_cap)
        
        # calculate total time
        dur = proc.time() - t0
        names(dur) = NULL
        runtime = dur[3]
        
        # create data.frame to hold message and run time
        stats = data.frame(tab="phph", msg="success", seconds=runtime)
        
        # collect into out
        out = list(status=stats, tables=tbls, plots=plts, prints=list(NULL))
        return(out)        
}