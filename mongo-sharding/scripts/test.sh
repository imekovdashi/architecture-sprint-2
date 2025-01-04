docker compose exec -T mongo-sharding mongosh --port 27017 --quiet <<EOF
use somedb
db.helloDoc.countDocuments()
EOF

docker compose exec -T shard1 mongosh --port 27020 --quiet <<EOF
use somedb
db.helloDoc.countDocuments()
EOF

docker compose exec -T shard2 mongosh --port 27021 --quiet <<EOF
use somedb
db.helloDoc.countDocuments()
EOF