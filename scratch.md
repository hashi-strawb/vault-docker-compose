# Scratchfile

Stuff to be converted to scripts (either to be run which will configure everything, or for me to type by hand)


# Pre-Demo Setup

Run:

```
./pre-demo-setup.sh
```



Download images:

```
docker pull consul:1.4.0
docker pull vault:1.1.3
```



TODO: Launch Vault, init, leave blank





# Demo: Restore Consul (OSS and Enterprise)



Start Consul

```
docker-compose up consul
```


Restore Snapshot

```
docker-compose exec consul sh -c "consul snapshot restore /tmp/snapshots/*.snap"
```


In the logs:

```
consul_1  |     2020/05/05 20:33:20 [INFO] snapshot: Creating new snapshot at /consul/data/raft/snapshots/2-130-1588710800209.tmp
consul_1  |     2020/05/05 20:33:20 [INFO] raft: Copied 69651 bytes to local snapshot
consul_1  |     2020/05/05 20:33:20 [INFO] raft: Restored user snapshot (index 130)
```




# Demo: Vault OSS (Not Working)

Have OSS Vault binary...

```
unzip -o vault_1.1.3_linux_amd64.zip
```


Start Vault

```
docker-compose up --build vault
```

Unseal with:
```
docker-compose exec vault bash --login

vault operator unseal
```
TODO: Unseal script


In Vault UI:
> You can unseal the vault by entering a portion of the master key. Once all portions are entered, the vault will be unsealed.


Unseal...


Vault logs:

```
vault_1   | 2020-05-05T20:42:14.805Z [INFO]  core: acquired lock, enabling active operation
vault_1   | 2020-05-05T20:42:14.846Z [INFO]  core: post-unseal setup starting
vault_1   | 2020-05-05T20:42:14.848Z [INFO]  core: loaded wrapping token key
vault_1   | 2020-05-05T20:42:14.848Z [INFO]  core: successfully setup plugin catalog: plugin-directory=
vault_1   | 2020-05-05T20:42:14.850Z [ERROR] core: failed to decompress and/or decode the mount table: error="no namespace"
vault_1   | 2020-05-05T20:42:14.850Z [INFO]  core: pre-seal teardown starting
vault_1   | 2020-05-05T20:42:14.850Z [INFO]  core: pre-seal teardown complete
vault_1   | 2020-05-05T20:42:14.850Z [ERROR] core: post-unseal setup failed: error="no namespace"
```




# Demo: Vault Enterprise (Working)

Have Enterprise Vault Binary...

```
unzip -o vault-enterprise_1.1.3+prem_linux_amd64.zip
```

Start Vault

```
docker-compose up --build vault
```

Unseal with:
```
docker-compose exec vault bash --login

vault operator unseal
```


In Vault UI:
> You can unseal the vault by entering a portion of the master key. Once all portions are entered, the vault will be unsealed.




In consul logs...

```
consul_1  |     2020/05/05 20:28:26 [INFO] agent: Synced check "vault:vault_primary:8200:vault-sealed-check"
consul_1  |     2020/05/05 20:28:30 [INFO] consul: member 'e1f4fe0f6465' joined, marking health alive
consul_1  |     2020/05/05 20:28:30 [INFO] consul: member '485aa16bc600' reaped, deregistering
consul_1  |     2020/05/05 20:28:36 [INFO] agent: Synced service "vault:vault_primary:8200"
consul_1  |     2020/05/05 20:28:36 [INFO] agent: Synced check "vault:vault_primary:8200:vault-sealed-check"
```







In Vault UI, we see our secret exists, and has all the keys again.
