# Changes the ownership of /data/db
echo "sudo chown -R vagrant /data/db" >> /home/vagrant/.bashrc
# Starts the replica service
echo "mongod --replSet rep1 --oplogSize 200 --port 27040 > shard.log &" >> /home/vagrant/.bashrc
# Reboots machine
sudo reboot
