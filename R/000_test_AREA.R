
# setup and initializing
remove(list = ls(all.names = TRUE))
cat("\014")
source("./R/load_clean.R")

CountryABBR <- "EG"
City <- "CAIRO" #ensure: captial letters

CountryABBR2 <- "JP"
City2 <- "OSAKA"

CityABBR <- paste0(CountryABBR, City)
name <- make_filename(CityABBR)

testfile <- read_and_load(name)
head(testfile)
tail(testfile)

(get_FileInfo(testfile, CountryABBR, City))



name2 <- make_filename(paste0(CountryABBR2, City2))
testfile2 <- read_and_load(name2)
head(testfile2)
tail(testfile2)

##
grid.newpage()
grid::grid.draw(ggplotGrob(p2))
md_inset <- viewport(x = 0.065, y = 0.89,
                     just = c("left", "top"),
                     width = 0.4, height = 0.1)
pushViewport(md_inset)
grid.draw(rectGrob(gp = gpar(alpha = 0.5, col = "white")))
grid.draw(rectGrob(gp = gpar(fill = NA, col = "black")))
grid::grid.draw(add_subtext())
popViewport()



# Try it out - modify the original plot
# p <- plot.title(p2, "Rainfall", "Location", 
#                size.1 = 20, size.2 = 15, 
#                col.1 = "red", col.2 = "blue", 
#                face.2 = "italic")


# Web Scraping
#     testing
#     source: https://rpubs.com/Radcliffe/superbowl
require(rvest)
url <- "http://academic.udayton.edu/kissock/http/Weather/citylistWorld.htm"
webpage <- read_html(url)
sb_table <- xml_nodes(webpage, "ul")
sb <- html_table(sb_table)[[1]]
