#!/bin/bash

function title {
    echo -ne "\033]0;"$*"\007"
}

title "Vault Unseal"

unseal_1=$(head -n 1 init.log | tail -n 1 | sed 's/.*: //')
unseal_2=$(head -n 2 init.log | tail -n 1 | sed 's/.*: //')
unseal_3=$(head -n 3 init.log | tail -n 1 | sed 's/.*: //')

# TODO: Provide unseal shards 1 and 2 automatically
echo ${unseal_1}
docker-compose exec vault bash --login -c "echo ${unseal_1}"
docker-compose exec vault bash --login -c "vault operator unseal ${unseal_1}"

echo ${unseal_2}
docker-compose exec vault bash --login -c "echo ${unseal_2}"
docker-compose exec vault bash --login -c "vault operator unseal ${unseal_2}"

echo
echo ==================================================
echo For purposes of demo, unseal key:
echo ${unseal_3}
echo ==================================================
echo
docker-compose exec vault bash --login
