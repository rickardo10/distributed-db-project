# Starts the query server service
echo "mongos --configdb config01:27018 --port 27019 --chunkSize 1 > /home/vagrant/query.log &" >> /home/vagrant/.bashrc
# Reboots machine
sudo reboot
