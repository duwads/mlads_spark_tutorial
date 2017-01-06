
user_name=diispark
amlToken=$1

################################################################################
## Get example datasets
################################################################################

## First, grab the taxi data
##### ------------------------ didn't work ---------- begin
cd  /home/"$user_name"/mlads_spark_tutorial
# copy code files for sparklyr exercise from Ali's GitHub repo
wget https://raw.githubusercontent.com/akzaidi/spark_nyc_taxi/master/raw_urls.txt
mkdir data/
cat raw_urls.txt | xargs -n 1 -P 6 wget -c -P data/
# put file in RevoShare directory too
hadoop fs -mkdir /user/RevoShare/"$user_name"/nyctaxi
hadoop fs -copyFromLocal data/ /user/RevoShare/"$user_name"/nyctaxi/
# cleanup
rm raw_urls.txt
##### ------------------------ didn't work ---------- end
 
## Second, grab the airline data 
cd data/
mkdir AirlineSubsetCsv
cd AirlineSubsetCsv
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/AirlineSubsetCsv/part-00000
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/AirlineSubsetCsv/part-00001
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/AirlineSubsetCsv/part-00002
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/AirlineSubsetCsv/part-00003
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/AirlineSubsetCsv/part-00004
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/AirlineSubsetCsv/part-00005
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/AirlineSubsetCsv/part-00006
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/AirlineSubsetCsv/part-00007
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/AirlineSubsetCsv/part-00008
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/AirlineSubsetCsv/part-00009
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/AirlineSubsetCsv/part-00010
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/AirlineSubsetCsv/part-00011
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/AirlineSubsetCsv/part-00012
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/AirlineSubsetCsv/part-00013
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/AirlineSubsetCsv/part-00014
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/AirlineSubsetCsv/part-00015

## Third, grab the weather data 
cd ..
mkdir WeatherSubsetCsv
cd WeatherSubsetCsv
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/WeatherSubsetCsv/part-00000
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/WeatherSubsetCsv/part-00001
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/WeatherSubsetCsv/part-00002
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/WeatherSubsetCsv/part-00003
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/WeatherSubsetCsv/part-00004
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/WeatherSubsetCsv/part-00005
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/WeatherSubsetCsv/part-00006
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/WeatherSubsetCsv/part-00007
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/WeatherSubsetCsv/part-00008
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/WeatherSubsetCsv/part-00009
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/WeatherSubsetCsv/part-00010
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/WeatherSubsetCsv/part-00011
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/WeatherSubsetCsv/part-00012
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/WeatherSubsetCsv/part-00013
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/WeatherSubsetCsv/part-00014
wget http://cdspsparksamples.blob.core.windows.net/data/Airline/WeatherSubsetCsv/part-00015
# get files where they need to be
cd /home/"$user_name"/
hadoop fs -mkdir /HdiSamples/HdiSamples/FlightDelay
hadoop fs -copyFromLocal data/* /HdiSamples/HdiSamples/FlightDelay/
# cleanup
rm -r data/

cd /home/"$user_name"

################################################################################
## Store the AML token in azureml-settings.json
################################################################################

sudo sed -i.bak "s/replaceWithToken/$amlToken/" /home/"$user_name"/MRS/azureml-settings.json

################################################################################
## Reduce spark logging, because it slows down RStudio
################################################################################

##### ------------------------ didn't work ---------- begin
sudo sed -i.bak 's/INFO/WARN/' /etc/spark/conf/log4j.properties
##### ------------------------ didn't work ---------- end

################################################################################
## Install packages but remove older version of packages prior to installation
################################################################################
cd /home/"$user_name"

# the tibble package now requires /bin/gtar
sudo ln -s /bin/tar /bin/gtar

sudo apt-get -y -qq install libcurl4-openssl-dev
sudo apt-get -y -qq install libcurl4-gnutls-dev
sudo apt-get -y -qq install libssl-dev
sudo apt-get -y -qq install libxml2-dev

cd /usr/lib64/microsoft-r/8.0/lib64/R/library
if [[ -d sparklyr ]]; then sudo rm -Rf sparklyr; fi;
if [[ -d sparkapi ]]; then sudo rm -Rf sparkapi; fi;
if [[ -d rprojroot ]]; then sudo rm -Rf rprojroot; fi;
if [[ -d dplyr ]]; then sudo rm -Rf dplyr; fi;
if [[ -d Rcpp ]]; then sudo rm -Rf Rcpp; fi;
if [[ -d DBI ]]; then sudo rm -Rf DBI; fi;
if [[ -d config ]]; then sudo rm -Rf config; fi;
if [[ -d tibble ]]; then sudo rm -Rf tibble; fi;
if [[ -d devtools ]]; then sudo rm -Rf devtools; fi;
if [[ -d rmarkdown ]]; then sudo rm -Rf rmarkdown; fi;
if [[ -d knitr ]]; then sudo rm -Rf knitr; fi;
if [[ -d AzureML ]]; then sudo rm -Rf AzureML; fi;
if [[ -d RCurl ]]; then sudo rm -Rf RCurl; fi;
if [[ -d rjson ]]; then sudo rm -Rf rjson; fi;
if [[ -d hts ]]; then sudo rm -Rf hts; fi;
if [[ -d fpp ]]; then sudo rm -Rf fpp; fi;
if [[ -d randomForest ]]; then sudo rm -Rf randomForest; fi;
if [[ -d readr ]]; then sudo rm -Rf readr; fi;

cd /home/"$user_name"/R/x86_64-pc-linux-gnu-library/3.2
if [[ -d rmarkdown ]]; then sudo rm -Rf rmarkdown; fi;

################################################################################
## call R file to remove old and then reinstall packages
################################################################################
cd /home/"$user_name"
sudo R --vanilla --quiet < /home/"$user_name"/mlads_spark_tutorial/setup/package_installs.R

################################################################################
## install RStudio
################################################################################
cd /home/"$user_name"/mlads_spark_tutorial/
sudo chmod 755 setup/InstallRStudio.sh
sudo ./setup/InstallRStudio.sh

################################################################################
## Change permission of entire directory
################################################################################
sudo chmod -R 777 /home/"$user_name"/mlads_spark_tutorial

################################################################################
## Set final working directory
################################################################################
cd /home/"$user_name"

wget https://raw.githubusercontent.com/akzaidi/mlads_spark_tutorial/master/verification.sh