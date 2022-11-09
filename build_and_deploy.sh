#!/bin/bash

repo="kalazzerx/sabnzbdvpn"
#see what the latest version (github sabnzbd/sabnzbd/releases)
ver=$(./get_sabnzdb_version.sh)

#todo - if ver equels
if [[ "${ver}" == "$(cat version_deployed)" ]]; then
    echo "sabnzdb version '${ver}' has already been deployed"
    echo "exiting"
    exit
fi

echo "Processing Version: '${ver}'"
echo

#docker build -t sabnzbdvpn ./
docker build --no-cache -t sabnzbdvpn ./
echo
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
echo $ver > version_deployed


