# Creates a directory for db
sudo mkdir -p /data/configdb
# Changes the ownership of /data/configdb
echo "sudo chown -R vagrant /data/configdb" >> /home/vagrant/.bashrc
# Starts the configsvr service
echo "mongod --configsvr --dbpath /data/configdb --port 27018 > /home/vagrant/monocfg.log &" >> /home/vagrant/.bashrc
# Reboots machine
sudo reboot
