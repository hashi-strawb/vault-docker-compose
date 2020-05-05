# Vault Docker Compose

A simple Docker Compose stack for running Vault, with Consul as backend storage.

This stack is primarily meant as a quick demo cluster, as part of my HashiConf Digital talk.

It is nowhere near Production ready, and you absolutely should not use it for that.

See the [Reference Architecture](https://learn.hashicorp.com/vault/operations/ops-reference-architecture) for guidelines on running Vault in Production.

## Dependencies

### Docker (and Docker Compose)

You can get those from [docker.com](https://docs.docker.com/get-docker/)

### Vault Binary

This stack is designed to run with a Vault binary of your choosing, be that Open Source or Enterprise.

For Open Source, download the the Linux_amd64 binary of your choice.

In my case, I'm using 1.1.3:

https://releases.hashicorp.com/vault/1.1.3/

For Enterprise... if you're a Vault Enterprise customer, HashiCorp will have provided you with instructions already for acquiring those binaries.

## Running

```
docker-compose up
```

## Configuring

Before the talk, pre-configure with:

```
./pre-demo-setup.sh
```

## Demo

TODO
