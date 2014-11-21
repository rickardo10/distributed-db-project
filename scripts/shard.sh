# Changes the owner of /data/db to vagrant in bashrc
echo "sudo chown -R vagrant /data/db" >> /home/vagrant/.bashrc
# Starts the service as shard in bash rc
echo "mongod --shardsvr --port 27040 > /home/vagrant/shard.log &" >> /home/vagrant/.bashrc
# Restarts
sudo reboot
