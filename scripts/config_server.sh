sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10

echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list

sudo apt-get -y update

sudo apt-get install -y vim

sudo apt-get install -y mongodb-org

sudo mkdir -p /data/db
sudo chown -R vagrant /data/db

sudo echo "10.0.0.11 shard01" >> /etc/hosts
sudo echo "10.0.0.12 shard02" >> /etc/hosts
sudo echo "10.0.0.13 shard03" >> /etc/hosts
sudo echo "10.0.0.14 query01" >> /etc/hosts
sudo echo "10.0.0.15 config01" >> /etc/hosts

sudo apt-get install openssh-server openssh-client

sudo mkdir -p /data/configdb
sudo chown -R vagrant /data/configdb

mongod --configsvr --dbpath /data/configdb --port 27018 > /home/vagrant/monocfg.log &

