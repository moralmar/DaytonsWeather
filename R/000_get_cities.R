


# source("./R/000_main_AREA.R")

# https://rpubs.com/bradleyboehmke/weather_graphic
# http://academic.udayton.edu/kissock/http/Weather/




url_cities <- "http://academic.udayton.edu/kissock/http/Weather/citywbanwmo.txt"
tt <- read_tsv(url_cities) # -- no


ext_tracks_colnames <- c("City", "OurFilename", "WBAN", "WMO")
ext_tracks_widths <- c(20,20,17,17)
data <- readr::read_fwf(url_cities, 
                        skip = 3,
                        col_types = "ccii",
                        fwf_widths(ext_tracks_widths, 
                                   ext_tracks_colnames)
                        )
data$OurFilename
data
