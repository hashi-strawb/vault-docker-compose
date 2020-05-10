#!/bin/bash

function title {
    echo -ne "\033]0;"$*"\007"
}

title "Vault (OSS)"

unzip -o vault_1.1.3_linux_amd64.zip

docker-compose up --build vault