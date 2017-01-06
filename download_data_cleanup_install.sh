
user_name=duwadsspark
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