# Initiates the replication and adds shards to replication
mongo --host shard01 --port 27040 --eval "rs.initiate()"
mongo --host shard01 --port 27040 --eval "rs.add('shard02:27040')"
# Add shards to cluster
mongo query01:27019 --eval "sh.addShard('shard03:27040')"
mongo query01:27019 --eval "sh.addShard('rep1/shard01:27040,shard02:27040')"

