

cranpkgs = c("AzureML",
             "devtools", 
             "dplyr",
             "ggplot2",
             "gridExtra",
             "knitr")


install.packages("Rcpp", repos = 'http://cran.us.r-project.org')
install.packages("rmarkdown", repos = 'http://cran.us.r-project.org')
install.packages(, repos = 'http://cran.us.r-project.org')
install.packages(, repos = 'http://cran.us.r-project.org')
install.packages(, repos = 'http://cran.us.r-project.org')
install.packages("RCurl", repos = 'http://cran.us.r-project.org')
install.packages("rjson", repos = 'http://cran.us.r-project.org')
install.packages("hts", repos = 'http://cran.us.r-project.org')
install.packages("fpp", repos = 'http://cran.us.r-project.org')
install.packages("randomForest", repos = 'http://cran.us.r-project.org')
install.packages("readr", repos = 'http://cran.us.r-project.org')
install.packages("sparklyr", repos = 'http://cran.us.r-project.org')
install.packages("formatR", repos = 'http://cran.us.r-project.org')
install.packages("tidyr", repos = 'http://cran.us.r-project.org')
install.packages("tibble", repos = 'http://cran.us.r-project.org')


ghpkgs = c()

library(devtools)
options(unzip = 'internal')

devtools::install_github("rstudio/config");
devtools::install_github("rstats-db/DBI");
devtools::install_github("krlmlr/rprojroot");
devtools::install_github("rstudio/sparkapi");

