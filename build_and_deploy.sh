#!/bin/bash

repo="kalazzerx/sabnzbdvpn"  #deploy to docker-hub
#repo="localhost:5001/sabnzbdvpn"  #deploy to local registry (localhost) 

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
if [[ ! $repo == *"localhost"* ]]; then
  echo "logging into docker"
  docker login
fi
 

docker tag sabnzbdvpn:latest ${repo}:${ver}
docker tag sabnzbdvpn:latest ${repo}:latest
docker push ${repo}:${ver}
docker push ${repo}:latest

# deploy to local registry
#docker tag  sabnzbdvpn:latest localhost:5001/sabnzbdvpn:latest
#docker push localhost:5001/sabnzbdvpn:latest


echo $ver > version_deployed


