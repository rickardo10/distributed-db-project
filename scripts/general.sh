# Imports the public key used by the package management system
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
# Creates a list file for MongoDB
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
# Reloads local package database.
sudo apt-get -y update
# Installs vim
sudo apt-get install -y vim
# Install mongodb
sudo apt-get install -y mongodb-org
# Creates the database directory
sudo mkdir -p /data/db
# Adds all the nodes to the host file
sudo echo "10.0.0.11 shard01" >> /etc/hosts
sudo echo "10.0.0.12 shard02" >> /etc/hosts
sudo echo "10.0.0.13 shard03" >> /etc/hosts
sudo echo "10.0.0.14 query01" >> /etc/hosts
sudo echo "10.0.0.15 config01" >> /etc/hosts
