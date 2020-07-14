# https://www.r-project.org/nosvn/pandoc/installr.html

getinstallr <- function(){
  my_pacman(); p_load(remotes)

  if (!require('installr')) detach("package:installr", unload = TRUE);
  if (!require("installr")) install.packages('installr'); remotes::install_github('talgalili/installr')
}

Rtools <- function(){my_pacman(); p_load(installr); install.Rtools()}

pacupdate <- function(){
  my_pacman()
  old.packages() # list all packages where an update is available
  installed.packages()
  p_update() # pacman's version of package update
}

rupdate <- function(){my_pacman(); p_load(installr); updateR(); p_update()}

updater <- function(){
  my_pacman(); p_load(installr)
  check <- check.for.updates.R()
  if(check) updateR(); p_update()
  return(check)
}

network <- function(){my_pacman(); p_load(installr); myip(); cranometer()}

gitinstall <- function(){my_pacman(); p_load(installr); install.git(); install.GitHub()}

usa_install <- function(){
  my_pacman(); p_load(devtools)
  install_github("ropensci/USAboundaries")
  install_github("ropensci/USAboundariesData")
}
