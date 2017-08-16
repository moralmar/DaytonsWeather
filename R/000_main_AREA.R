
remove(list = ls(all.names = TRUE))
cat("\014")

source("./R/load_clean.R")
source("./R/wrangling.R")
source("./R/plotting.R")
source("./R/load_packages.R")

pkgsName <- c("readr","magrittr","ggplot2","dplyr", "gridExtra")
pkgs <- package(pkgsName)
lapply(pkgsName, require, character.only = TRUE)

CountryABBR <- "EG"; City <- "CAIRO" #ensure: captial letters
CityABBR <- paste0(CountryABBR, City)

# make file name
name <- make_filename(CityABBR)

# read
testfile <- read_and_load(name)
(get_FileInfo(testfile, CountryABBR, City))

# wrangling
YearToday <- 2014L
YearPastMin <- min(testfile$Year)
YearPastMax <- YearToday - 1

PastData <- get_YearData(testfile, YearPastMin:YearPastMax)
DataYearX <- get_YearData(testfile, YearToday)

PastExtremes <- get_YearPastExtremes(PastData)
head(PastExtremes); tail(PastExtremes)

YearXExtremes <- get_ExtremesForYearX(PastExtremes, DataYearX)


# plotting
p1 <- ggplot() + 
        geom_linerange(PastExtremes, mapping = aes(x = seqDay, 
                                         ymin = PastLow, 
                                         ymax = PastHigh), 
                       colour = "wheat2", 
                       alpha=.8)

p2 <- create_base_plot(City, PastExtremes, 
                       DataYearX, 
                       YearXExtremes, 
                       YearPastMin, 
                       YearPastMax, 
                       YearToday) %>%
        add_line_yearX(DataYearX) %>%
        add_formatting(feb_days = 29, PastExtremes) %>%
        add_ExtremePoints(YearXExtremes) +
        theme_dayton()

gridExtra::grid.arrange(p1, p2)



# require(ggjoy)
# tt <- data.frame(year = PastData$Year, avg = PastData$avg) %>%
#         filter(year == 2013 | year == 1995)
# 
# ggplot(tt, aes(x = avg, y = year, group = year)) +
#         geom_joy() + 
#         theme_joy()
        
        
