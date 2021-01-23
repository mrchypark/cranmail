library(httr)
library(rvest)
library(stringr)

tar <- "https://cran.r-project.org/web/packages/available_packages_by_name.html"

tar %>%
  read_html() %>%
  html_nodes("a") %>%
  html_attr("href") %>%
  .[!str_detect(., "available")] %>%
  str_replace_all(fixed("../.."), fixed("https://cran.r-project.org")) ->
  plist


