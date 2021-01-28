library(httr)
library(rvest)
library(stringr)
library(dplyr)

tar <- "https://cran.r-project.org/web/packages/available_packages_by_name.html"

tar %>%
  read_html() %>%
  html_nodes("a") %>%
  html_attr("href") %>%
  .[!str_detect(., "available")] %>%
  str_replace_all(fixed("../.."), fixed("https://cran.r-project.org")) ->
  plist

plist[1] %>%
  read_html() %>%
  html_table() %>%
  .[[1]]  -> tobj

tobj %>%
  filter(str_detect(X1, "Author")) %>%
  pull(X2)  -> author

tobj %>%
  filter(str_detect(X1, "Maintainer")) %>%
  pull(X2)  -> mtner
