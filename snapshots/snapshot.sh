#!/bin/sh

CONSUL_SNAPSHOT_DIR=/tmp/snapshots

# Our actual consul snapshot script does much more than this
# e.g. sends Prometheus a notification to let us know it was successful

snapshot_file=${CONSUL_SNAPSHOT_DIR}/democonsul01_consul_snapshot_$(date +%Y%m%d.%H%M%S).snap

echo ================================================================================
echo Saving Consul Snapshot to ${snapshot_file}
echo ================================================================================
consul snapshot save -token=${CONSUL_TOKEN} ${snapshot_file}
consul snapshot inspect ${snapshot_file}
