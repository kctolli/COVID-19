# https://www.r-project.org/nosvn/pandoc/installr.html

getinstallr <- function(){
  pacman::p_load(pacman, remotes)

  if (!require('installr')) detach("package:installr", unload = TRUE);
  if (!require("installr")) install.packages('installr'); remotes::install_github('talgalili/installr')
}

Rtools <- function(){
  pacman::p_load(installr); install.Rtools()
}

pacupdate <- function(){
  pacman::p_load(pacman)
  old.packages() # list all packages where an update is available
  installed.packages()
  p_update() # pacman's version of package update
}

rupdate <- function(){
  pacman::p_load(pacman, installr)
  updateR(); p_update()
}

updater <- function(){
  pacman::p_load(pacman, installr)
  check <- check.for.updates.R()
  if(check) updateR(); p_update()
  return(check)
}

network <- function(){
  pacman::p_load(pacman, installr)
  myip(); cranometer()
}

gitinstall <- function(){
  pacman::p_load(pacman, installr)
  install.git(); install.GitHub()
}

usa_install <- function(){
  pacman::p_load(pacman, installr, devtools)
  install_github("ropensci/USAboundaries")
  install_github("ropensci/USAboundariesData")
}
