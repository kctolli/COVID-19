libraries <- function() {
  pacman::p_load(pacman, knitr, tidyverse, package)
  p_load(installr, sys, here, callr, testthat, assertive)
  p_load(gh, git2r, devtools, downloader, broom)
  p_load(lubridate, dygraphs, data.table, DT, tibble, timetk)
  p_load(sf, USAboundaries, ggrepel, maps, leaflet, forcats, sqldf)
  p_load(glue, purrr, readxl, rvest, tidyquant, stringi, mlr, dbplyr)

  knit_options()
}

knit_options <- function(){
  pacman::p_load(pacman, knitr)
  opts_chunk$set(echo = TRUE, message = FALSE, warning = FALSE)
  options(scipen = 999)
  options(warn = -1)
}
