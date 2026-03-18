#!/bin/sh

set -e

SECRETS_FILE="DisneyFinder/Secrets.xcconfig"
API_HOST_VALUE="${API_HOST:-api.disneyapi.dev}"

cat > "$SECRETS_FILE" <<EOC
//
//  Secrets.xcconfig
//  DisneyFinder
//

API_HOST = $API_HOST_VALUE
EOC

echo "Secrets file created at: $SECRETS_FILE"
echo "API_HOST = $API_HOST_VALUE"
