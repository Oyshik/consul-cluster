# Consul Cluster

[Consul] is a powerfull tool which can be used for service discovery, kv store , monitoring health of a service. The consul is designed to work in HA mode across datacenter.

Here in this docker image we are trying to create a clustered cosul within a docker swarm. So if you launch this service in a replicated ( with more than 2 replicas) or global mode ( for multinode environment) , the replicase will discover among themselves and form a consul cluster.

# How to run 
First step would be to create a swarm overlay network 
```sh
$ docker network create --driver overlay --subnet=192.168.1.0/24 consul-net
```
Then we can start the service as follows
 ```sh
$  docker service create --name consul \
        -p 8500:8500 \
        --mode global \
        --network consul-net \
        oyshikmoitra/consul-cluster:v1.0
```

# Configuration 
While running this image as a docker service we need to take care that 
  - The name of the service need to be "consul" . This used for discovery of nodes. If you want to a change this you can set the environment variable SERVICE_NAME
  - The serive would generally wait till atleast 2 replicas have come up before trying to start the consul cluster. This quorum can be changed by updating the environment variable MIN_QUORUM 
  

   
   
   [Consul]: <https://www.consul.io/>
