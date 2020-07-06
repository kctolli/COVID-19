libraries <- function() {
  pacman::p_load(pacman)
  p_load(knitr, tidyverse, package)
  p_load(installr, sys, here, learnr)
  p_load(gh, git2r, devtools, downloader)
  p_load(lubridate, dygraphs, data.table, DT, tibble)
  p_load(sf, USAboundaries, ggrepel, maps, leaflet, forcats)
  p_load(glue, purrr, readxl, rvest, tidyquant, stringi, mlr)

  knit_options()
}

knit_options <- function(){
  pacman::p_load(pacman, knitr)
  opts_chunk$set(echo = TRUE)
  options(scipen = 999)
  options(warn = -1)
}
