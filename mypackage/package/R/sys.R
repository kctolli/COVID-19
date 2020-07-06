getinstallr <- function(){
  pacman::p_load(pacman)
  p_load(installr)

  if (!require('remotes')) install.packages('remotes');

  if (!require('installr')) detach("package:installr", unload = TRUE);
  if (!require("installr")) install.packages('installr'); remotes::install_github('talgalili/installr')

  install.Rtools()
}

pacupdate <- function(){
  old.packages() # list all packages where an update is available

  installed.packages()

  pacman::p_update() # pacman's version of package update
}

rupdate <- function(){
  # https://www.r-project.org/nosvn/pandoc/installr.html

  pacman::p_load(pacman)

  p_load(installr)

  require2(installr)
  updateR()

  p_update()
}

updater <- function(){
  pacman::p_load(pacman)
  p_load(installr)

  check <- check.for.updates.R()

  if(check) updateR(); p_update()

  return(check)
}

Sys.Check <- function(){
  pacman::p_load(pacman)
  p_load(installr)
  p_detectOS()

  is.windows()
  is.x64()

  is.RStudio()
  is.Rgui()
}

network <- function(){
  pacman::p_load(pacman)
  p_load(installr)

  myip()
  cranometer()
}

gitinstall <- function(){
  install.git()
  install.GitHub()
}
