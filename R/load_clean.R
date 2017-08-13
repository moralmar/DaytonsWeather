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




make_filename <- function(CityABBR) {
        filePathSep <- "/"
        fileNamesep <- "."
        fileExt <- "txt"
        baseURL <- "http://academic.udayton.edu/kissock/http/Weather/gsod95-current"
        
        filename <- paste(CityABBR, fileExt, sep = fileNamesep)
        finalURL <- paste(baseURL, filename, sep = filePathSep)
        
} # END make_filename()

get_FileInfo <- function(CityFile, CountryABBR, City){
        # start with an empty data frame:
        #     not really needed if only one file is looked at
        # df <- data.frame(name = c(), size = c()) 
        fileInfo <- object.size(CityFile)
        fileSizeInMb <- paste(round(fileInfo / 1024 / 1024, 2), "MB")
        df <- data.frame(name = paste(CountryABBR, City), size = fileSizeInMb)
} #END get_FileInfo


read_and_load <- function(finalURL){
        ext_tracks_colnames <- c("Month", "Day", "Year", "TempInF")
        ext_tracks_widths <- c(8,9,17,17)
        # data <- readr::read_fwf(finalURL) #col_names = FALSE
        data <- readr::read_fwf(finalURL, 
                                fwf_widths(ext_tracks_widths, 
                                           ext_tracks_colnames)
                                )
        return(data)
}
