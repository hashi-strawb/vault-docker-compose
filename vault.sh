#!/bin/bash

function title {
    echo -ne "\033]0;"$*"\007"
}

title Vault

docker-compose up --build vault
