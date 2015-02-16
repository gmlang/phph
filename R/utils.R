trim = function (x) gsub("^\\s+|\\s+$", "", x)

#' Creates a function that draws boxplots
#' 
#' @param df A data frame
#' @return a function that takes three arguments:
#'              xvar     : a string specifying the categorical x variable
#'              yvar     : a string specifying the continuous y variable
#'              degree   : a number specifying the angle of x-axis tick labels
#'              vpos     : a number specifying the additional height of the text
#'                         labels beyond the max y-value of each group shown on 
#'                         the main graph
#'              log_y    : a logical value specifying whether to use log10 scale
#'                         on y-axis. Default is FALSE                         
mk_box_plt = function(df) {
        function(xvar, yvar, degree=0, vpos=0, log_y=FALSE, ylab_str="") {
                axis.txt = ggplot2::element_text(angle = degree, size=14, 
                                                 family="sans", face="bold")
                axis.title = ggplot2::element_text(size=18, family="sans", 
                                                   vjust=2)
                
                p = ggplot2::ggplot(df, ggplot2::aes_string(x = xvar, y = yvar, 
                                                            fill = xvar)) + 
                        ggplot2::geom_boxplot() + 
                        ggplot2::guides(fill = FALSE) + 
                        ggplot2::labs(x = "", y = ylab_str) +
                        ggplot2::stat_summary(fun.y = mean, geom = "point", 
                                              shape = 5, size = 2) +
                        ggplot2::stat_summary(fun.data = function(x) 
                                c(y = max(x) + vpos, label = length(x)), 
                                geom = "text", size = 5) + 
                        ggplot2::theme(axis.text.x = axis.txt,
                                       axis.text.y = axis.txt,
                                       axis.title.x = axis.title,
                                       axis.title.y = axis.title)
                if (log_y)
                        p = p + ggplot2::scale_y_log10()
                p
        }
}