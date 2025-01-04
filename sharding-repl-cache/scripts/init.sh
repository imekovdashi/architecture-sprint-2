docker compose exec -T configSrv mongosh --port 27019 --quiet <<EOF
console.log("Инициализация configSrv" + "\n");
rs.initiate(
  {
    _id : "config_server",
       configsvr: true,
    members: [
      { _id : 0, host : "configSrv:27019" }
    ]
  }
);
exit(); 
EOF

sleep 2

docker compose exec -T shard1-1 mongosh --port 27020 --quiet <<EOF
console.log("Инициализация shard1-1");
rs.initiate(
    {
      _id : "shard1",
      members: [
        { _id : 0, host : "shard1-1:27020" },
        { _id : 1, host : "shard1-2:27021" },
        { _id : 2, host : "shard1-3:27022" },
      ]
    }
);
exit();
EOF

sleep 2

docker compose exec -T shard2-1 mongosh --port 27023 --quiet <<EOF
console.log("Инициализация shard2-1");
rs.initiate(
    {
      _id : "shard2",
      members: [
        { _id : 0, host : "shard2-1:27023" },
        { _id : 1, host : "shard2-2:27024" },
        { _id : 2, host : "shard2-3:27025" },
      ]
    }
  );
exit(); 
EOF

sleep 5

docker compose exec -T sharding-repl-cache mongosh --port 27017 --quiet <<EOF
console.log("Инициализация sharding-repl-cache");
sh.addShard( "shard1/shard1-1:27020");
sh.addShard( "shard2/shard2-1:27023");

sh.enableSharding("somedb");
sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } )

use somedb

for(var i = 0; i < 1000; i++) db.helloDoc.insertOne({age:i, name:"ly"+i})

db.helloDoc.countDocuments() 
exit(); 
EOF