#Docker-ElasticSearch

Dockerfile for elasticsearch.
Base: ubuntu

#Usage

```
git clone git@github.com:yss44/docker_elasticsearch.git
cd docker_elasticsearch
vim bin/build bin/run
```
In {bin/build` and `bin/run`, change variable USER to yourname!

```
chmod +x bin/*
./bin/build
./bin/run
```

Container port is forwarded to Host's port 9200.

For check elasticsearch works.

```
$ curl -XGET localhost:9200/_cluster/health?pretty
{
  "cluster_name" : "elasticsearch",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 0,
  "active_shards" : 0,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0
}
```

ok!
