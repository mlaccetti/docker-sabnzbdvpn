#!/bin/bash

repo="kalazzerx/sabnzbdvpn"


docker build -t sabnzbdvpn ./
echo
echo
ver=$(./get_sabnzdb_version.sh)
echo "Version: '${ver}'"
echo

read -p "Continue Docker tag/push? (y/N) " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

#custom registry
#docker login registry.example.com
echo "logging into docker"


docker login
docker tag sabnzbdvpn:latest ${repo}:${ver}
docker tag sabnzbdvpn:latest ${repo}:latest
docker push ${repo}:${ver}
docker push ${repo}:latest


