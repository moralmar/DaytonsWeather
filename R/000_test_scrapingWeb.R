


# source("./R/000_main_AREA.R")

# https://rpubs.com/bradleyboehmke/weather_graphic
# http://academic.udayton.edu/kissock/http/Weather/

require(rvest)
url <- "http://academic.udayton.edu/kissock/http/Weather/citylistWorld.htm"
webpage <- read_html(url)
ul_table <- xml_nodes(webpage, "ul")
ul_text <- xml_text(ul_table)


head(ul_text)


# now: try to extract
# -- with gsub
# -- or with str_extract

require(stringr)

tt <- gsub(".*\r\n\\s*", "", ul_text[1])
tt


tt2 <- str_extract(string = ul_text, pattern = "(?<= ).*(?=.txt)")


pattern <- "ALA (.*?) .txt"
result <- regmatches(ul_text[1], regexec(pattern, ul_text[1]))
result


