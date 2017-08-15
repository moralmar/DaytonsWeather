################ ~~~~~~~~~~~~~~~~~ ######## ~~~~~~~~~~~~~~~~~ ##################
##                                                                            ##
##                              Daytons Weather                               ## Lilly, next week: exams
##                                                                            ##
##                                                                            ##
##                              Marco R. Morales                              ##
##                                                                            ##
##                                                                            ##
## created: 06.08.2017                                last update: 06.08.2017 ##
################# ~~~~~~~~~~~~~~~~~ ######## ~~~~~~~~~~~~~~~~~ #################

# https://rpubs.com/bradleyboehmke/weather_graphic
# http://academic.udayton.edu/kissock/http/Weather/

theme_dayton <- function(base_size = 11, base_family = 'sans'){
        dayton <- ggplot2::theme_minimal(base_size = base_size, 
                                           base_family = base_family) +
                                                  theme(panel.grid.major = element_blank(),
                                                        panel.grid.minor = element_blank(),
                                                        axis.ticks = element_blank(),
                                                        plot.title = element_text(face = "bold",
                                                                                  hjust = 0.012,
                                                                                  vjust = 0.8,
                                                                                  color = "#3C3C3C",
                                                                                  size = 20)
                                                  )
                   dayton
}





create_base_plot <- function(df_PastExtremes, 
                             df_DataYearX, 
                             df_YearXExtremes, 
                             YearPastMin, 
                             YearPastMax, 
                             YearToday){
        
        n_days <- nrow(df_DataYearX)
        feb_days <- ifelse(n_days == 364, 28, 29)
        feb_days <- 29
        
        year_current <- max(df_DataYearX$Year) # Year to look at ("current year")
        
        y_maxValue <- plyr::round_any(range(PastExtremes$PastHigh)[2], 10, f = ceiling)
        
        temp_value <- plyr::round_any(range(PastExtremes$PastHigh)[1], 10, f = floor)
        y_minValue <- ifelse(temp_value > 0, 0, temp_value)
        
        
        p1 <- ggplot() + 
                geom_linerange(df_PastExtremes, mapping = aes(x = seqDay, 
                                                           ymin = PastLow, 
                                                           ymax = PastHigh), 
                               colour = "wheat2", 
                               alpha = 1) +
                geom_linerange(df_PastExtremes, mapping = aes(x = seqDay,
                                                              ymin = PastAvgLow, 
                                                              ymax = PastAvgHigh),
                               colour = "wheat4") +
                geom_line(df_DataYearX, mapping = aes(x = seqDay, y = TempInC, group = 1)) +
                geom_vline(xintercept = 0, colour = "wheat4", linetype=1, size=1) +
                
                geom_hline(yintercept = 0, colour = "white", linetype=1) +
                geom_hline(yintercept = 5, colour = "white", linetype=1) +
                geom_hline(yintercept = 10, colour = "white", linetype=1) +
                geom_hline(yintercept = 15, colour = "white", linetype=1) +
                geom_hline(yintercept = 20, colour = "white", linetype=1) +
                geom_hline(yintercept = 25, colour = "white", linetype=1) +
                geom_hline(yintercept = 30, colour = "white", linetype=1) +
                geom_hline(yintercept = 35, colour = "white", linetype=1) +
                geom_hline(yintercept = 40, colour = "white", linetype=1) +
                
                geom_vline(xintercept = 31, colour = "wheat4", linetype=3, size=.5) +
                geom_vline(xintercept = 31 + feb_days, colour = "wheat4", linetype=3, size=.5) +
                geom_vline(xintercept = 2*31 + 0*30 + feb_days, colour = "wheat4", linetype=3, size=.5) +
                geom_vline(xintercept = 2*31 + 1*30 + feb_days, colour = "wheat4", linetype=3, size=.5) +
                geom_vline(xintercept = 3*31 + 1*30 + feb_days, colour = "wheat4", linetype=3, size=.5) +
                geom_vline(xintercept = 3*31 + 2*30 + feb_days, colour = "wheat4", linetype=3, size=.5) +
                geom_vline(xintercept = 4*31 + 2*30 + feb_days, colour = "wheat4", linetype=3, size=.5) +
                geom_vline(xintercept = 4*31 + 3*30 + feb_days, colour = "wheat4", linetype=3, size=.5) +
                geom_vline(xintercept = 5*31 + 3*30 + feb_days, colour = "wheat4", linetype=3, size=.5) +
                geom_vline(xintercept = 5*31 + 4*30 + feb_days, colour = "wheat4", linetype=3, size=.5) +
                geom_vline(xintercept = 6*31 + 4*30 + feb_days, colour = "wheat4", linetype=3, size=.5) +
                geom_vline(xintercept = 6*31 + 5*30 + feb_days, colour = "wheat4", linetype=3, size=.5) +
                
                scale_x_continuous(expand = c(0,0),
                                   breaks = c(15, 45, 75, 105, 135, 165, 198, 228, 258, 288, 320, 350),
                                   position = "top",
                                   labels = c("January", "February", "March", "April",
                                              "May", "June", "July", "August", "September",
                                              "October", "November", "December")) +
                geom_point(data = df_YearXExtremes[df_YearXExtremes$recordLow == "Y", ], 
                           aes(x = seqDay, y = TempInC), color = "blue3") +
                geom_point(data = df_YearXExtremes[df_YearXExtremes$recordHigh == "Y", ], 
                           aes(x = seqDay, y = TempInC), color = "firebrick3") + 
                
                ylim(y_minValue, y_maxValue) +
                
                labs(x = "", y = expression("Temperature in "*~degree*C)) +
                
                annotate("text", label = "Temperature", 
                         x = 19, y = y_maxValue - 0.5, size = 4, fontface="bold") +
                annotate("text", x = 68, y = y_maxValue - 2.5, 
                         label = "Data represents average daily temperatures. Accessible data dates back to", 
                         size=3, colour="gray30") +
                annotate("text", x = 63, y = y_maxValue - 4, 
                         label = "January 1, 1995. Data for 2014 is only available through December 16.", 
                         size=3, colour="gray30") +
                annotate("text", x = 67, y = y_maxValue - 5.5, 
                         label = "Average temperature for the year was 51.9° making 2014 the 9th coldest", 
                         size=3, colour="gray30") +
                annotate("text", x = 17, y = y_maxValue - 7, label = "year since 1995", 
                         size=3, colour="gray30") +
                
                ggtitle(paste("Dayton's Weather in ", YearToday))
        return(p1)
}



# not in use
add_subtext <- function(){
        
        gridText <- grid.text("Temperature.....", x = 0, y = 1, 
                              rot = 0, 
                              just = "left", vjust = 1)
        grid::grid.draw(gridText)
}


# not in use
plot.title = function(plot = NULL, text.1 = NULL, text.2 = NULL, 
                      size.1 = 12,  size.2 = 12,
                      col.1 = "black", col.2 = "black", 
                      face.1 = "plain",  face.2 = "plain") {
        
        require(gtable)
        require(grid)
        
        gt = ggplotGrob(plot)
        
        text.grob1 = textGrob(text.1, y = unit(.45, "npc"), 
                              gp = gpar(fontsize = size.1, col = col.1, fontface = face.1))
        text.grob2 = textGrob(text.2,  y = unit(.65, "npc"), 
                              gp = gpar(fontsize = size.2, col = col.2, fontface = face.2))
        
        text = matrix(list(text.grob1, text.grob2), nrow = 2)
        text = gtable_matrix(name = "title", grobs = text, 
                             widths = unit(1, "null"), 
                             heights = unit.c(unit(1.1, "grobheight", text.grob1) + unit(0.5, "lines"), unit(1.1,  "grobheight", text.grob2) + unit(0.5, "lines")))
        
        gt = gtable_add_grob(gt, text, t = 2, l = 4)
        gt$heights[2] = sum(text$heights)
        
        class(gt) =  c("Title", class(gt))
        
        gt
}

# not in use
# A print method for the plot
printNewGrid <- function(x) {
        grid.newpage()   
        grid.draw(x)
}
