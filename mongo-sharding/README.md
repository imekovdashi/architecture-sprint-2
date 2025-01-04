# mongo-sharding

## Как запустить

Запускаем mongodb и приложение

```shell
docker compose up -d
```

Заполняем mongodb данными

```shell
./scripts/init.sh
```

## Как проверить

Откройте в браузере http://localhost:8080

```shell
./scripts/test.sh
```

После запуска скрипта в консоль выведутся следующие строки (количество документов в шардах может отличаться).

```
[direct: mongos] test> switched to db somedb
[direct: mongos] somedb> 1000
[direct: mongos] somedb> shard1 [direct: primary] test> switched to db somedb
shard1 [direct: primary] somedb> 492
shard1 [direct: primary] somedb> shard2 [direct: primary] test> switched to db somedb
shard2 [direct: primary] somedb> 508
shard2 [direct: primary] somedb>
```