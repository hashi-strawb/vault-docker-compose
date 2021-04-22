#!/bin/bash

docker-compose exec consul sh -c "consul snapshot restore /tmp/snapshots/*.snap"
