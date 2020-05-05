#!/bin/bash
set -euo pipefail

# Set things up prior to the demo



# Wipe out anything that already exists

echo ====================
echo Cleanup
echo ====================

docker-compose down
rm init.log || true
rm snapshots/*.snap || true

echo
echo ====================
echo Starting Stack
echo ====================

docker-compose up -d --build

echo
echo ====================
echo Init
echo ====================
echo

# Init, and keep track of keys and root token
for i in {1..5}
do
	sleep 5
	docker-compose exec vault bash --login -c "vault operator init" | tee init.log && break

	# Retry every 5 seconds if it fails (i.e. because Vault is not up yet)
done


# TODO: parse init.log
# For now, human input is fine
echo
echo Paste the Vault Token from above:
read -s VAULT_TOKEN

echo And three of the unseal keys 1/3:
read -s UNSEAL_KEY_1
echo unseal key 2/3:
read -s UNSEAL_KEY_2
echo unseal key 3/3:
read -s UNSEAL_KEY_3

export VAULT_ADDR=http://0.0.0.0:8200

echo
echo ====================
echo Unseal Vault
echo ====================

vault operator unseal ${UNSEAL_KEY_1}
vault operator unseal ${UNSEAL_KEY_2}
vault operator unseal ${UNSEAL_KEY_3}

echo
echo ====================
echo Configuring Vault
echo ====================

# Give ourselves an easy root token for signing into the UI
# Really bad in production, but handy for this demo
vault write auth/token/create policies=root id=root

# Enable KVv1
vault secrets enable -version=1 -path=secret/ kv

# Create a secret
vault write secret/test/ada \
	name="Ada Lovelace" \
	bio="The first programmer, yo" \
	age="probably dead by now, but who knows?" \
	avatar="http://en.wikipedia.org/wiki/File:Ada_lovelace.jpg"

# Enable auth
vault auth enable userpass

# Create a user
vault write auth/userpass/users/lucy password=test policies=admin

# And a policy
cat << EOF > /tmp/policy.hcl
path "secret/*" {
	capabilities = ["create", "read", "update", "delete", "list"]
}
EOF
vault policy write admin /tmp/policy.hcl

# Create a child namespace
# We don't need it, but this forces the snapshot to fail in OSS
vault namespace create test


echo
echo ====================
echo Creating several short TTL tokens
echo ====================

for i in {1..50}
do
	# These will expire after the Vault snapshot is restored
	vault token create -ttl=1m -policy=default -field=token
done


echo
echo ====================
echo Creating consul snapshot
echo ====================
docker-compose exec consul sh -c "/tmp/snapshots/snapshot.sh"



echo
echo ====================
echo Vault Logs
echo ====================

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

function ctrl_c() {
	echo "** Trapped CTRL-C"
	docker-compose down
}


# So we can watch and wait for the tokens to expire
docker-compose logs -f vault



