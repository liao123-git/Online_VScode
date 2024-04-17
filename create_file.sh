#!/bin/bash

sudo rm -rf /editor/players/*
sudo mkdir -p /editor/players
sudo rm -rf /editor/coredns/*
sudo mkdir -p /editor/coredns/players

sudo echo '.:53 {
    forward . 114.114.114.114 8.8.8.8
    log
    errors
}
' > /editor/coredns/Corefile