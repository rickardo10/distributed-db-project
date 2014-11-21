# This stepts have to be followed after vagrant is up


# Starts the shards service this line has to be runned in each rep server
#mongod --replSet rep1 --oplogSize 200 --port 27040 > shadr.log &

# Initiates the replication and adds shards to replication
#mongo --host shard01 --port 27040 --eval "rs.initiate()"
#mongo --host shard01 --port 27040 --eval "rs.add('shard02:27040')"
#mongo --host shard01 --port 27040 --eval "rs.add('shard03:27040')"

# Add shards to cluster
#mongo --host query01 --port 27019
#mongos>sh.addShard("shard01")
