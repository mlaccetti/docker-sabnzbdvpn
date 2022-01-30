#!/bin/bash

SABNZBD_ASSETS=$(curl -sX GET "https://api.github.com/repos/sabnzbd/sabnzbd/releases" | jq '.[] | select(.prerelease==false) | .assets_url' | head -n 1 | tr -d '"')
SABNZBD_DOWNLOAD_URL=$(curl -sX GET ${SABNZBD_ASSETS} | jq '.[] | select(.name | contains("tar.gz")) .browser_download_url' | tr -d '"')
SABNZBD_NAME=$(curl -sX GET ${SABNZBD_ASSETS} | jq '.[] | select(.name |
    contains("tar.gz")) .name' | tr -d A'"')
#echo "NAME: ${SABNZBD_NAME}"
#echo "URL: ${SABNZBD_DOWNLOAD_URL}"
short_version=$(echo $SABNZBD_NAME | cut -d'-' -f2 )
echo ${short_version}

