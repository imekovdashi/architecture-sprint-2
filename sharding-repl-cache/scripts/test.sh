docker compose exec -T sharding-repl-cache mongosh --port 27017 --quiet <<EOF
use somedb
console.log("Общее количество документов: " + db.helloDoc.countDocuments());

EOF

docker compose exec -T shard1-1 mongosh --port 27020 --quiet <<EOF
use somedb
console.log("Количество документов в shard1: " + db.helloDoc.countDocuments());
const status = rs.status();
const replicaCount = status.members.length;
console.log("Количество реплик в наборе shard1: " + replicaCount);
EOF

docker compose exec -T shard2-1 mongosh --port 27023 --quiet <<EOF
use somedb
console.log("Количество документов в shard2: " + db.helloDoc.countDocuments());
const status = rs.status();
const replicaCount = status.members.length;
console.log("Количество реплик в наборе shard2: " + replicaCount);
EOF