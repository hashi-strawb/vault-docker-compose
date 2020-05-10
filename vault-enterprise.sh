#!/bin/bash

function title {
    echo -ne "\033]0;"$*"\007"
}

title "Vault (Enterprise)"

unzip -o vault-enterprise_1.1.3+prem_linux_amd64.zip

docker-compose up --build vault

