@echo off
D:
cd "Program Files\MongoDB\Server\4.0\bin"

start cmd /k mongod --replSet catchemshard1 --dbpath "D:\data\catchem\shard1" --port 27020 --shardsvr
start cmd /k mongod --replSet catchemshard2 --dbpath "D:\data\catchem\shard2" --port 27021 --shardsvr
start cmd /k mongod --replSet catchemconfig --dbpath "D:\data\catchem\config" --port 27022 --configsvr
start cmd /k mongos --logpath "mongos.log" --configdb "catchemconfig/localhost:27022" --port 27023

PAUSE