#' ---
#' title: "R Package Installation"
#' author: '2017-01-06'
#' date: "Duncan Wadsworth"
#' ---

#' list R packages available on CRAN
cranpkgs = c('AzureML',
             'config',
             'DBI',
             'devtools', 
             'dplyr',
             'formatR',
             'fpp',
             'ggplot2',
             'gridExtra',
             'hts',
             'knitr',
             'Rcpp',
             'RCurl',
             'randomForest',
             'readr',
             'rjson',
             'rmarkdown',
             'rprojroot',
             'sparkapi',
             'sparklyr',
             'tibble',
             'tidyr')

#' remove old versions first, if they exist
remove.packages(cranpkgs)

#' install 'em
install.packages(cranpkgs, repos = 'http://cran.us.r-project.org')

#' list R packages available on GitHub
#ghpkgs = c('config', 'DBI', 'rprojroot', 'sparkapi')

#' remove old versions first, if they exist
#remove.packages(ghpkgs)

#' install 'em
#library(devtools)
#options(unzip = 'internal')
#install_github('rstudio/config')
#install_github('rstats-db/DBI')
#install_github('krlmlr/rprojroot')
#install_github('rstudio/sparkapi')

