#!/bin/bash

# Todo: read TELEPORT_DOMAIN and TELEPORT_EDITION from environment variables

TELEPORT_EDITION="cloud"
TELEPORT_DOMAIN="abernicchia.teleport.sh"
TELEPORT_VERSION=$(curl -sSf "https://${TELEPORT_DOMAIN}/v1/webapi/automaticupgrades/channel/stable/cloud/version" | sed 's/v//') 

echo "Installing Teleport version: $TELEPORT_VERSION" 

curl https://cdn.teleport.dev/install.sh | bash -s ${TELEPORT_VERSION?} ${TELEPORT_EDITION?}
