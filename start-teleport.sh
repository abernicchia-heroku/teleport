#!/bin/bash

# Exit on any error
set -e

# Check required environment variables
required_vars=("DYNO" "TP_CLUSTER_DOMAIN_NAME" "PORT" "TP_LICENSE")
for var in "${required_vars[@]}"; do
    if [ -z "${!var}" ]; then
        echo "Error: Required environment variable $var is not set"
        exit 1
    fi
done

# Create temporary file with environment variables substituted
envsubst '$DYNO,$TP_CLUSTER_DOMAIN_NAME,$PORT' < teleport-template.yaml > teleport.yaml.tmp

# Copy config file to the correct location
mv teleport.yaml.tmp /etc/teleport.yaml

# Write license file
echo "$TP_LICENSE" | tee /var/lib/teleport/license.pem > /dev/null

# Ensure correct permissions
chmod 600 /var/lib/teleport/license.pem
chmod 644 /etc/teleport.yaml

cat /etc/teleport.yaml

# Start Teleport
exec teleport start --config="/etc/teleport.yaml"

