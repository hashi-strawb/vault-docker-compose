#!/bin/bash

function title {
    echo -ne "\033]0;"$*"\007"
}

title Consul

docker-compose up consul
