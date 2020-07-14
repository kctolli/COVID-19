libraries <- function(){my_pacman(); my_main(); knit_options(); my_load()}

my_pacman <- function(){pacman::p_load(pacman, package)}

my_main <- function(){my_pacman(); p_load(tidyverse, knitr)}

knit_options <- function(){
  my_pacman(); my_main()
  opts_chunk$set(echo = TRUE,
                 message = FALSE,
                 warning = FALSE)
  options(scipen = 999,
          warn = -1)
}

my_load <- function(){
  my_pacman()

  p_load(downloader,
         devtools,
         installr,
         sys,
         here,
         callr,
         testthat,
         assertive,
         rgdal,
         gh,
         DT,
         git2r,
         broom,
         htmltools,
         htmlwidgets,
         lubridate,
         dygraphs,
         data.table,
         tibble,
         timetk,
         sf,
         USAboundaries,
         ggrepel,
         maps,
         leaflet,
         forcats,
         sqldf,
         glue,
         purrr,
         readxl,
         rvest,
         tidyquant,
         stringi,
         mlr,
         dbplyr,
         curl,
         DBI,
         fs,
         maps,
         markdown,
         modelr,
         openssl,
         plotly,
         readxl,
         remotes,
         rmarkdown,
         roxygen2,
         selectr,
         servr,
         shiny,
         testthat,
         usethis,
         sparklyr,
         rlang,
         reticulate,
         caret,
         h2o,
         Rcpp,
         albersusa)
}
