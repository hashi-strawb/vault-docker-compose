#!/bin/bash

function title {
    echo -ne "\033]0;"$*"\007"
}

title "Vault Unseal"

head -7 init.log

docker-compose exec vault bash --login
