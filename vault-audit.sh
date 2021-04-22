#!/bin/bash

function title {
    echo -ne "\033]0;"$*"\007"
}

title Vault Audit

docker-compose exec vault sh -c "nc -l 5170"
