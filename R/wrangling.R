################ ~~~~~~~~~~~~~~~~~ ######## ~~~~~~~~~~~~~~~~~ ##################
##                                                                            ##
##                              Daytons Weather                               ##
##                                                                            ##
##                                                                            ##
##                              Marco R. Morales                              ##
##                                                                            ##
##                                                                            ##
## created: 06.08.2017                                last update: 06.08.2017 ##
################# ~~~~~~~~~~~~~~~~~ ######## ~~~~~~~~~~~~~~~~~ #################



get_YearData <- function(data, YearsOfInterest){

        Past <- data %>%
                dplyr::group_by(Year) %>%
                dplyr::mutate(seqDay = seq(1, length(Day))) %>%
                dplyr::ungroup() %>%
                dplyr::filter(TempInF != -99 & Year %in% YearsOfInterest) %>% # missing values = -99
                dplyr::group_by(seqDay) %>%
                dplyr::mutate(TempInC = (TempInF - 32) / 1.8,
                              upper = max(TempInC), 
                              lower = min(TempInC),
                              avg = mean(TempInC),
                              se = sd(TempInC) / sqrt(length(TempInC)),
                              avg_upper = avg + (2.101 * se),
                              avg_lower = avg - (2.101 * se)) %>%
                ungroup()
}

get_YearPastExtremes <- function(PastData){
        Low <- PastData %>%
                dplyr::group_by(seqDay) %>%
                dplyr::summarise(PastLow = min(TempInC),
                                 PastHigh = max(TempInC),
                                 PastAvg = mean(TempInC),
                                 PastSe = sd(TempInC) / sqrt(length(TempInC)),
                                 PastAvgLow = PastAvg - (2.101 * PastSe),
                                 PastAvgHigh = PastAvg + (2.101 * PastSe))
}


get_ExtremesForYearX <- function(PastYearExtremes, DataYearX){
      
        
        Low_YearX <- DataYearX %>%
                dplyr::left_join(PastYearExtremes) %>%
                mutate(recordLow = ifelse(TempInC < PastLow, "Y", "N"),
                       recordHigh = ifelse(TempInC >= PastHigh, "Y", "N"))
                
}


